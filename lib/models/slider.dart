class SliderModels {
   String image;
  
  
 SliderModels(this.image);

}

List<SliderModels> slidermodels =
  data.map((item) => SliderModels(item["image"].toString(),)).toList();

  var data= [
    {
      "image" : "assets/banner1.jpg",
    },
    // {
    //   "image" : "assets/banner2.jpg",
    // },

  ];