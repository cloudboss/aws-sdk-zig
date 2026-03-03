/// Settings specific to Teletext caption sources, including Page number.
pub const TeletextSourceSettings = struct {
    /// Use Page Number to specify the three-digit hexadecimal page number that will
    /// be used for Teletext captions. Do not use this setting if you are passing
    /// through teletext from the input source to output.
    page_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .page_number = "PageNumber",
    };
};
