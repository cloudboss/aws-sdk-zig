/// Specify the XAVC Intra 4k (CBG) Class to set the bitrate of your output.
/// Outputs of the same class have similar image quality over the operating
/// points that are valid for that class.
pub const Xavc4kIntraCbgProfileClass = enum {
    class_100,
    class_300,
    class_480,

    pub const json_field_names = .{
        .class_100 = "CLASS_100",
        .class_300 = "CLASS_300",
        .class_480 = "CLASS_480",
    };
};
