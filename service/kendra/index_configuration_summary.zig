const IndexEdition = @import("index_edition.zig").IndexEdition;
const IndexStatus = @import("index_status.zig").IndexStatus;

/// Summary information on the configuration of an index.
pub const IndexConfigurationSummary = struct {
    /// The Unix timestamp when the index was created.
    created_at: i64,

    /// Indicates whether the index is a Enterprise Edition index or a Developer
    /// Edition index.
    edition: ?IndexEdition = null,

    /// A identifier for the index. Use this to identify the index when you are
    /// using APIs such as
    /// `Query`, `DescribeIndex`, `UpdateIndex`, and
    /// `DeleteIndex`.
    id: ?[]const u8 = null,

    /// The name of the index.
    name: ?[]const u8 = null,

    /// The current status of the index. When the status is `ACTIVE`, the index is
    /// ready to search.
    status: IndexStatus,

    /// The Unix timestamp when the index was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .edition = "Edition",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
