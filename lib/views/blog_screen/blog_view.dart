import 'package:explorergocustomer/consts/consts.dart';
// import 'package:explorergocustomer/controllers/blogcontroller.dart';

class BlogDetails extends StatefulWidget {
  
  final String? title;
  final dynamic data;
  const BlogDetails({super.key, this.title, this.data});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}
class _BlogDetailsState extends State<BlogDetails> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: widget.title!.text.size(18).semiBold.color(highEmphasis).make()
              ),
              5.heightBox,
              SizedBox(
                width: double.infinity,
                height: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                    // aspectRatio: 16/9,
                    autoPlay: true,
                    height: 216,
                    enlargeCenterPage: true,
                    itemCount: widget.data['blogimglinks'].length,
                    itemBuilder: (context,index){
                      return Image.network(widget.data['blogimglinks'][index], height: 216, width: double.infinity,
                      fit: BoxFit.cover,
                      ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make();
                    }),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 20, color: primary,),
                        '${widget.data['bloglocation']}'.text.color(fontGrey).fontFamily(regular).size(20).make(),
                      ],
                    ),
                  ],
                ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)). outerShadow.make(),
              ),
              10.heightBox,
              '${widget.data['blogdetail']}'.text.make()
            ],
          ),
        ),
      ),
    );
  }
}