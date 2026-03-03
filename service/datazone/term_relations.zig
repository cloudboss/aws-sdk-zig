/// The details of the term relations.
pub const TermRelations = struct {
    /// The classifies of the term relations.
    classifies: ?[]const []const u8 = null,

    /// The `isA` property of the term relations.
    is_a: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .classifies = "classifies",
        .is_a = "isA",
    };
};
