pub const AzureAccessTier = enum {
    hot,
    cool,
    archive,

    pub const json_field_names = .{
        .hot = "HOT",
        .cool = "COOL",
        .archive = "ARCHIVE",
    };
};
