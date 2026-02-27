pub const BrowserType = enum {
    chrome,
    firefox,

    pub const json_field_names = .{
        .chrome = "CHROME",
        .firefox = "FIREFOX",
    };
};
