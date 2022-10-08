class DokumentasiModels {
   String image;
  
  
 DokumentasiModels(this.image);

}

List<DokumentasiModels> dokumentasimodels =
  data.map((item) => DokumentasiModels(item["image"].toString(),)).toList();

  var data= [
    {
      "image" : "assets/dok1.jpg",
    },
    {
      "image" : "assets/dok2.jpg",
    },
    {
      "image" : "assets/dok3.jpg",
    },

  ];