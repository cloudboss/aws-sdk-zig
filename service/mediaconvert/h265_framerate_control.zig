/// Use the Framerate setting to specify the frame rate for this output. If you
/// want to keep the same frame rate as the input video, choose Follow source.
/// If you want to do frame rate conversion, choose a frame rate from the
/// dropdown list or choose Custom. The framerates shown in the dropdown list
/// are decimal approximations of fractions. If you choose Custom, specify your
/// frame rate as a fraction.
pub const H265FramerateControl = enum {
    initialize_from_source,
    specified,

    pub const json_field_names = .{
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
        .specified = "SPECIFIED",
    };
};
