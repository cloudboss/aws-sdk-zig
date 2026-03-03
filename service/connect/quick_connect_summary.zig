const QuickConnectType = @import("quick_connect_type.zig").QuickConnectType;

/// Contains summary information about a quick connect.
pub const QuickConnectSummary = struct {
    /// The Amazon Resource Name (ARN) of the quick connect.
    arn: ?[]const u8 = null,

    /// The identifier for the quick connect.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the quick connect.
    name: ?[]const u8 = null,

    /// The type of quick connect. In the Amazon Connect admin website, when you
    /// create a quick connect, you are
    /// prompted to assign one of the following types: Agent (USER), External
    /// (PHONE_NUMBER), or Queue (QUEUE).
    quick_connect_type: ?QuickConnectType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .quick_connect_type = "QuickConnectType",
    };
};
