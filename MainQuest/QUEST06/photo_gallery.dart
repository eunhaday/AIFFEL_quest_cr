import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


/*============================================================
* 갤러리앱의 기능설명
*
* - class : Folder -> 사진폴더, Photo -> 사진정보
* - main page : PhotoGallery
*               FolderListPage : 사진폴더를 보여주눈 page
*               PhotoListPage  : 사진목록을 보여주는 page
*               PhotoDetailPage: 선택된 사진 1장의 정보를 상세히 표시
*
* - PhotoDetailPage의 상세화면에 사진에 대한 폴더 및 사진정보를 표시하기
*   위하여 StatefulWidget 로 3개다 구성
*
* - 각종 class의 객체 및 변수의 초기화는 StatefulWidget에 선언이 필요하고
*   State 에 각종 변수의 값을 설정한다.
* - 초기화때 값의 세팅이 불가한 특정변수인 path, filename은 ?로 선언해주고
*   initState() 의 setState() 에 값을 세팅하는것을 확인함
*
* - 기능은 폴더추가, 폴더삭제, 이미지업로드, 카메라, 자료분류 기능을 추가함
*   그중 구현이 추가로 필요한건 이미지업로드, 카메라, 자료분류임
* 
* - 보완필요기능 정리
*  -> 폴더생성시 New Folder_x 의 형태로 만드는 기능 추가필요
*  -> 사진정보의 ID의 경우는 최종 ID를 찾아서 id+1의 값으로 생성필요
*  -> 사진정보의 fullpath는 선택된 파일의 path정보로, filename도 해당 파일명으로 추가필요
*
* (회고)
* 우선 쉬운 기능부터 하나씩 실습을 해보는게 중요한거 같다.
* 구글링을 하던 GPT로 하던 sample을 돌려보고 해당부분을 붙여보는게
* 이해하는데 많은 도움이 되는것 같다.
* 에러가 나도 다시 물어보고 원인을 정확히 아는게 필요한거 같다.
* 추후 에뮬레이터를 올리고 이미지 관련 기능을 붙여봐야 겠다.
* =============================================================*/

//폴더정보 class 구조 선언
class Folder {
  String name;
  IconData icon;
  List<Photo> photos;  //사진정보를 추가

  Folder({required this.name, required this.icon, required this.photos});
}

//사진정보 class 구조선언
class Photo {
  String fullPath;  //폴더경로 및 파일명정보
  int id;       //사진id
  String title; //사진이름
  String? path;  //폴더경로
  String? filename; //파일명

  Photo(this.fullPath, this.id, this.title);
}

//main화면
void main() {
  runApp(PhotoGallery());
}

//처음 로딩시 화면에 표시되는 페이지로 사진갤러리 화면을 호출한다.
class PhotoGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FolderListPage(),
    );
  }
}


/*-----------------------------------------------------------
// 사진갤러리 화면 page (FolderListPage)
// - 아이콘이름,아이콘이미지를 표시하고,
//   이미지 탭하면 해당 사진목록의 사진들을 보여주는 화면호출한다.
//-----------------------------------------------------------*/
class FolderListPage extends StatefulWidget {
  @override
  _FolderListPageState createState() => _FolderListPageState();
}

//실제 처리되는 사진갤러리 폴더리스트 정보
class _FolderListPageState extends State<FolderListPage> {

  // Sample folders and photos
  final List<Folder> folders = [
    Folder(name: 'Animals', icon: Icons.pets, photos: [ //Animals 폴더
      Photo('images/gallery/animal_photo/20220520_220646.jpg', 1, '귀여운녀석들'),
      Photo('images/gallery/animal_photo/Screenshot_20241030_140319_Gallery.jpg', 2, '땅콩 귀엽다'),
      Photo('images/gallery/animal_photo/Screenshot_20241030_140335_Gallery.jpg', 3, '홍시 목에 리본'),
      Photo('images/gallery/animal_photo/Screenshot_20241030_140356_Gallery.jpg', 4, '햇볕에 샤워중인 땅콩'),
      Photo('images/gallery/animal_photo/Screenshot_20241030_140403_Gallery.jpg', 5, '뭘 노려봐~'),
      Photo('images/gallery/animal_photo/Screenshot_20241030_140514_Gallery.jpg', 6, '등위에 리본이!'),
    ]),
    Folder(name: 'Camera', icon: Icons.photo_camera, photos: [ //Camera 폴더
      Photo('images/gallery/camera/20240523_081554.jpg', 7, '빗질'),
      Photo('images/gallery/camera/20240523_081558.jpg', 8, '아이구! 털뭉치들'),
      Photo('images/gallery/camera/20240523_081607.jpg', 9, '빗질 도구들'),
      Photo('images/gallery/camera/20240523_081616.jpg', 10, '계란 2개가.ㅋㅋ'),
      Photo('images/gallery/camera/20240523_081639.jpg', 11, '크기봐라~~'),
    ]),
    Folder(name: 'File', icon: Icons.folder, photos: [ //File 폴더
      Photo('images/gallery/File_photo/20160415_060650.jpg', 12, ''),
      Photo('images/gallery/File_photo/20160415_061326.jpg', 13, ''),
      Photo('images/gallery/File_photo/20180322_184539.jpg', 14, ''),
    ]),
    Folder(name: 'Flower', icon: Icons.local_florist, photos: [ //Flower 폴더
      Photo('images/gallery/flower_photo/20160331_063643.jpg', 15, '연산홍'),
      Photo('images/gallery/flower_photo/20160408_113242.jpg', 16, '자스민'),
      Photo('images/gallery/flower_photo/20160602_231331.jpg', 17, ''),
      Photo('images/gallery/flower_photo/20160602_231424.jpg', 18, '치자꽃'),
      Photo('images/gallery/flower_photo/20161220_070206.jpg', 19, ''),
    ]),
    Folder(name: 'interior', icon: Icons.home_repair_service, photos: [ //interior 폴더
      Photo('images/gallery/interior_photo/Screenshot_20240613-222049_Samsung Internet.jpg', 20, '방묘문'),
      Photo('images/gallery/interior_photo/Screenshot_20240613-232450_Samsung Internet.jpg', 21, '다락아래 쪽장'),
      Photo('images/gallery/interior_photo/Screenshot_20240613-232622_Samsung Internet.jpg', 22, '테라스공간'),
      Photo('images/gallery/interior_photo/Screenshot_20240614-004204_Samsung Internet.jpg', 23, '복층계단 시공사례'),
      Photo('images/gallery/interior_photo/Screenshot_20240614-010350_Samsung Internet.jpg', 24, '각종 붙박이장 시공사례'),
      Photo('images/gallery/interior_photo/Screenshot_20240614-010418_Samsung Internet.jpg', 25, '이쁜 인테리어 사진'),
    ]),
  ];

  String result = ""; //vgg16모델 호출결과 받는 변수
  TextEditingController urlController = TextEditingController(); // URL을 입력 받는 컨트롤러(자료분류 기능관련)

  Folder? selectedFolder; //선택된 폴더를 저장하는 변수, 추가된 폴더를 수정하거나 삭제시 이용
  bool _isTextFieldVisible = false;  //자료분류버튼 클릭시 edit버튼 visible처리를 하기 위하여
  
  //폴더추가시 빈폴더로 이름은 New Folder로 해서 생성됨, Folder class의 내용만으로 일단 생성함
  void _addFolder() {
    setState(() {
      folders.add(Folder(name: 'New Folder', icon: Icons.create_new_folder_outlined, photos: []));
    });
  }

  //선택된 폴더를 삭제를 삭제하기 위해서, 폴더목록을 보여주는 다이알로그 박스를 띄운다.
  void _deleteFolder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("폴더 삭제"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: folders.map((folder) {
              return ListTile(
                title: Text(folder.name),
                leading: Icon(folder.icon),
                onTap: () {
                  setState(() {
                    selectedFolder = folder; // 선택한 폴더
                  });
                  Navigator.of(context).pop();
                  _confirmDeleteFolder(); // 최종 확인을 위한 다이알로그 박스
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소"),
            ),
          ],
        );
      },
    );
  }

  //삭제전 최종 확인하는 다이알로그 박스를 띄워서 삭제한다.
  void _confirmDeleteFolder() {
    if (selectedFolder != null) {//선택된 폴더가 있으면 처리함
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("폴더 삭제 확인"),
            content: Text("${selectedFolder!.name} 폴더와 포함된 사진을 삭제하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    folders.remove(selectedFolder); //선택된 폴더를 삭제
                    selectedFolder = null; //삭제후 선택된 폴더를 null로 처리함
                  });
                  Navigator.of(context).pop();
                },
                child: Text("삭제"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("취소"),
              ),
            ],
          );
        },
      );
    }
  }


  //선택된 폴더의 폴더명을 수정하는 기능
  void _editFolderName(Folder folder) {

    TextEditingController _controller = TextEditingController(text: folder.name); //폴더명의 edit를 저장하는 _controller

    //모달 다이알로그 박스로 저장, 취소로 폴더명 변경여부를 판단한다.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("폴더명 변경"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "폴더명을 변경하세요"),
          ),
          actions: [
            TextButton( //저장버튼을 눌렀을때 처리하는 부분
              onPressed: () {
                setState(() {
                  folder.name = _controller.text; //변경한 폴더명
                });
                Navigator.of(context).pop();
              },
              child: Text("저장"),
            ),
            TextButton( //취소버튼을 눌렀을때 처리하는 부분
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소"),
            ),
          ],
        );
      },
    );
  }

  //서버에 있는 참조할 API주소를 등록하고, vgg16모델을 이용하여 특정폴더의
  // 이미지 사진이 무엇인지 라벨과 정확도값을 화면에 표시하는 자료분류기 기능
  Future<void> fetchData() async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"), // 입력된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = "예측라벨: ${data['predicted_label']}\n예측_점수: ${data['prediction_score']})";
        });
      } else {
        setState(() {
          result = "데이터를 가져오지 못했습니다. 상태코드(Status Code): ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('사진 갤러리(Photo Gallery)')),
      appBar: AppBar(
        backgroundColor: Colors.amber,  //Colors.blue, // AppBar colob
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo, size: 30, color: Colors.indigo), //앱바에 아이콘이미지 추가
            Expanded( child: Text("  사진 갤러리(Photo Gallery)", textAlign: TextAlign.start,),),
          ],
        ),
      ),
      body: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: folders.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(folders[index].icon),
                              title: Text(folders[index].name),

                              //listview의 선택된 폴더가 selectedFolder로 저장한 변수와 같을경우
                              //selected=true, 아니면 selected=false로 값을 가짐
                              selected: selectedFolder == folders[index],

                              onTap: () { //해당 폴더를 눌렀을때
                                setState(() {
                                  selectedFolder = folders[index]; //선택된 폴더의 index값을 selectedFolder 변수에 세팅
                                });

                                Navigator.push( //PhotoListPage 화면호출
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoListPage(folder: folders[index]),
                                  ),
                                );
                              },
                              onLongPress: () { //위젯을 길게 누르는 경우 수정하는 상태로 인지하고 폴더명을 변경함
                                _editFolderName(folders[index]);
                              },
                            );
                          },
                        ),
                      ),
                      //
                      if (_isTextFieldVisible) ...[
                        SizedBox(height: 5),
                        TextField(
                          controller: urlController, // URL 입력을 위한 TextField
                          decoration: InputDecoration(labelText: "URL 입력"), // 입력 필드의 라벨
                        ),
                        ElevatedButton(
                          onPressed: fetchData,
                          child: Text("데이터 가져오기"),
                        ),
                        SizedBox(height: 8),
                        Text(result, style: TextStyle(fontSize: 15),),
                      ],
                    ],
                ),
              ),
            ),
            VerticalDivider(width: 1), // Optional divider
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  IconButton(icon: Icon(Icons.create_new_folder), tooltip: '[폴더추가], 좌측의 폴더에 신규로 추가됩니다.',
                    onPressed: _addFolder, ),
                  IconButton(icon: Icon(Icons.folder_delete), tooltip: '[폴더삭제], 좌측의 선택된 폴더 및 포함된 사진전부를 삭제합니다.',
                    onPressed: _deleteFolder, ),
                  IconButton(icon: Icon(Icons.drive_folder_upload), tooltip: '[파일업로드], 추가를 원하는 사진을 폴더에 추가할수 있습니다.',
                      onPressed: ()  {}),
                  IconButton(icon: Icon(Icons.linked_camera), tooltip: '[사진추가], 카메라로 찍은 사진을 카메라폴더에 추가합니다.',
                      onPressed: () {
                      }),
                  IconButton(icon: Icon(Icons.manage_search), tooltip: '[사진분류], 카메라폴더의 사진을 모델을 통해서 기존폴더나 신규폴더에 이동하여 추가합니다.',
                      onPressed: () {
                        setState(() {
                          _isTextFieldVisible = !_isTextFieldVisible;
                          result = "";
                          urlController.text = "";
                        });
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

/*-----------------------------------------------------------
// 사진목록정보 화면 page (PhotoListPage)
// - 선택된 폴더정보를 받아서 해당 앱바에 폴더이름을 표시하고,
//   해당 폴더의 전체갯수에서 가로로 3줄씩 표시하게 한다.
// - 해당 이미지 탭시에 상세화면을 호출한다.
//-----------------------------------------------------------*/
class PhotoListPage extends StatefulWidget {
  final Folder folder;

  PhotoListPage({required this.folder});

  @override
  _PhotoListPageState createState() => _PhotoListPageState();
}

//실제 처리되는 사진목록정보 기능
class _PhotoListPageState extends State<PhotoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.folder.name+' 폴더')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,   // 그리드의 가로 열 개수 설정 (3열)
            mainAxisSpacing: 10,  // 그리드 아이템 간의 위아래 간격 설정
            crossAxisSpacing: 10, // 그리드 아이템 간의 좌우 간격 설정
          ),
          itemCount: widget.folder.photos.length,  //itemCount=폴더내 사진이미지 전체갯수
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () { //탭 이벤트 발생시 사진상세화면을 호출(파라메터: folder.photos[index])
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PhotoDetailPage(folder: widget.folder, photo: widget.folder.photos[index]),  //folder, photo정보 각각 넘긴다.
                  ),
                );
              },
              child: Image.asset(widget.folder.photos[index].fullPath, fit: BoxFit.cover),  //사진목록정보 화면에 표시하는 정보(폴더-사진 전체정보)
            );
          },
        ),
      ),
    );
  }
}


/*-----------------------------------------------------------
// 사진목록정보 화면 page (PhotoDetailPage)
// - 선택된 폴더정보-사진정보의 index를 받아서 (folder.photos[index])
//   사진의 상세정보를 표시
//-----------------------------------------------------------*/
class PhotoDetailPage extends StatefulWidget {
  final Folder folder; //폴더정보로 화면에 표시하기 위하여 파라메터로 넘긴걸 선언해서 이용
  final Photo photo;

  PhotoDetailPage({required this.folder, required this.photo});

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  late TextEditingController _titleController;
  bool isEditing = false; //title을 edit or save 모드를 세팅하기 위한 변수

  @override
  void initState() { //초기에 상태값을 초기화한다.
    super.initState();
    _titleController = TextEditingController(text: widget.photo.title); //화면 로딩시 표시될 제목정보

    //state의 상태를 변경할때 호출되는 함수
    setState(() {
      //fullPath 값을 가지고 맨앞에서(0) ~ /의 맨마지막(lastIndexOf('/') + 1) 까지 잘라서 폴더경로 값을 설정
      widget.photo.path = widget.photo.fullPath.substring(0, widget.photo.fullPath.lastIndexOf('/') + 1);

      //fullPath 값을 가지고 마지막 '/' 다음만 잘라서 파일명을 설정
      widget.photo.filename = widget.photo.fullPath.split('/').last;
    });

  }

  @override
  void dispose() { //객체를 소멸할때 자동으로 호출된다.
    _titleController.dispose();
    super.dispose();
  }

  /*------------------------------------------------------------------------
  * isEditing=false인 경우는 edit모드, true인 경우는 save모드로 변경함
  * ( 처음에는 enabled: false로 editing 불가한 상태를 edit 가능하게 변경하는 기능임
  *   더불어 editing이후는 저장 기능까지 처리하게 수정됨 )
  -------------------------------------------------------------------------*/
  void _toggleEditing() {
    setState(() {
      debugPrint('_toggleEditing before > isEditing: $isEditing');

      isEditing = !isEditing; //isEditing=false인 상태를 true로 변경한다. (현재는 editing상태이므로 변경된 부분이 있을것으로 가정)

      debugPrint('_toggleEditing after> isEditing: $isEditing');

      if (!isEditing) { //isEditing=false인 경우만
        debugPrint('_toggleEditing if in > _titleController.text: ${_titleController.text}, widget.photo.title: ${widget.photo.title}');
        widget.photo.title = _titleController.text; //화면에 수정된값을 class변수에 세팅(변수=화면에 수정된 값을 같게함)
      }

      debugPrint('_toggleEditing if out > _titleController.text: ${_titleController.text}, widget.photo.title: ${widget.photo.title} \n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사진상세 정보')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.photo.fullPath, fit: BoxFit.cover),
            SizedBox(width: 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "[ 사진정보 ]",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    """아래정보는 사진의 상세정보로
사진의 제목을 변경하고자 하는 경우,
아래의 편집 버튼을 눌러서 작업을 하시면 됩니다.

저장버튼은 변경된 정보를 저장시,
취소버튼은 변경된 정보를 취소시 눌러주세요.
""",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: widget.folder.name),
                    decoration: InputDecoration(labelText: "폴더명(Name) : "),
                    enabled: false,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: widget.photo.id.toString()), //int->String으로 변환
                    decoration: InputDecoration(labelText: "번호(ID) :"),
                    enabled: false,
                  ),
                  SizedBox(height: 8),
                  TextField(
                      //controller: TextEditingController(text: widget.photo.title),
                      controller: _titleController, //변수의 값을 가지고 있는 TextEditingController, 수정시 해당값을 계속 가지고 처리함
                      decoration: InputDecoration(labelText: "제목(Title) : "),
                      //enabled: false,
                      enabled: isEditing, //처음엔 false, 이후 아이콘버튼을 클릭시 edit되면서 true로 변경함
                  ),
                  SizedBox(height: 8),
                  TextField(
                      controller: TextEditingController(text: widget.photo.path),
                      decoration: InputDecoration(labelText: "폴더위치(Path) : "),
                      enabled: false,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: TextEditingController(text: widget.photo.filename),
                    decoration: InputDecoration(labelText: "파일명(FileName) : "),
                    enabled: false,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton( //isEditing=true이면 save버튼, false이면 edit 가능한 상태를 표시함, 처음엔 false이므로 editing 상태가 됨
                        icon: Icon(isEditing ? Icons.save : Icons.edit, size: 30, color: Colors.red),
                        tooltip: '해당버튼을 눌러서 제목을 수정 및 저장 할수 있습니다.',
                        onPressed: _toggleEditing,
                      ),

                      if (isEditing) //edit->true->save상태임, 저장기능수행
                        IconButton(
                          icon: Icon(Icons.cancel, size: 30, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              debugPrint('build > Icons.cancel, isEditing:$isEditing');
                              isEditing = false; //edit상태로 다시 수정하게 하기위해서 false로 변경
                              debugPrint('build > Icons.cancel, isEditing:$isEditing, _titleController.text: ${_titleController.text}, widget.photo.title: ${widget.photo.title}');
                              _titleController.text = widget.photo.title; // 변경전 제목값으로 세팅
                              debugPrint('build > Icons.cancel, isEditing:$isEditing, _titleController.text: ${_titleController.text}, widget.photo.title: ${widget.photo.title} \n');
                            });
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}