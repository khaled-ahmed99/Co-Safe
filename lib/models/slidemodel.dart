class SlideModel {
  String? assetImagePath, title, desc;
  List<SlideModel> getSlides() {
    List<SlideModel> slides = [];
    SlideModel slide1 = SlideModel();
    slide1.assetImagePath = 'assets/images/aboutourapp.png';
    slide1.title = 'About our app';
    slide1.desc =
        'Our application the main purpose of it to save your life by generating a random ID for your device. To help ensure these random IDs can\’t be used to identify you or your location.';
    slides.add(slide1);
    SlideModel slide2 = SlideModel();
    slide2.assetImagePath = 'assets/images/mobile.png';
    slide2.title = 'How it work';
    slide2.desc =
        'Your phone and the phones around you will work in the background to exchange these privacy-preserving random IDs via Bluetooth. You do not need to have the app open for this process to take place';
    slides.add(slide2);
    SlideModel slide3 = SlideModel();
    slide3.assetImagePath = 'assets/images/best_tips.png';
    slide3.title = 'How app warn you';
    slide3.desc =
        'If there’s a match, you will receive a COVID-19 exposure notification, with further instructions from your public health authority on how to keep you and the people around you safe.';
    slides.add(slide3);
    return slides;
  }
}
