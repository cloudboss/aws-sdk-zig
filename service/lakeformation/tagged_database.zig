const DatabaseResource = @import("database_resource.zig").DatabaseResource;
const LFTagPair = @import("lf_tag_pair.zig").LFTagPair;

/// A structure describing a database resource with LF-tags.
pub const TaggedDatabase = struct {
    /// A database that has LF-tags attached to it.
    database: ?DatabaseResource,

    /// A list of LF-tags attached to the database.
    lf_tags: ?[]const LFTagPair,

    pub const json_field_names = .{
        .database = "Database",
        .lf_tags = "LFTags",
    };
};
