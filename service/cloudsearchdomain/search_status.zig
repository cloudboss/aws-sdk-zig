/// Contains the resource id (`rid`) and the time it took to process the request
/// (`timems`).
pub const SearchStatus = struct {
    /// The encrypted resource ID for the request.
    rid: ?[]const u8,

    /// How long it took to process the request, in milliseconds.
    timems: i64 = 0,

    pub const json_field_names = .{
        .rid = "rid",
        .timems = "timems",
    };
};
