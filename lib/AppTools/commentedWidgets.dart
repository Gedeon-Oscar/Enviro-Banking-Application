/*

  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              // icon and text for the error message
              Container(
                margin: const EdgeInsets.only(right:6.00),
                child: const Icon(Icons.info, color: Colors.white),
              ), 
              const Text(
                'Erorr occured while signin', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18
                )
              ),
            ],
          ),
          backgroundColor: navyBlu.withOpacity(1.0),
          duration: const Duration( seconds: 10 ),
        ), 
  );

*/





/*

// http get-reuesit
  // this variable will store the string returned by the REST API which you will keep for the user's session to make subsequent API calls.
  var _gwtToken = ""; 
  Future<void> getToken() async {
    try{
      var url = Uri.parse( '#' );
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(response.statusCode == 200 ){
        var jsondata = json.decode(response.body) as String;
        setState(() {
          _gwt = jsondata;
        });
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              // icon and text for the error message
              Container(
                margin: const EdgeInsets.only(right:6.00),
                child: const Icon(Icons.info, color: Colors.white),
              ), 
              Text(
                e.toString(), 
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 18
                )
              ),
            ],
          ),
          backgroundColor: navyBlu.withOpacity(1.0),
          duration: const Duration( seconds: 10 ),
        ),
      );
    }
  }

*/