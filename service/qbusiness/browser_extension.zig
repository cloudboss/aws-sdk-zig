pub const BrowserExtension = enum {
    firefox,
    chrome,

    pub const json_field_names = .{
        .firefox = "FIREFOX",
        .chrome = "CHROME",
    };
};
