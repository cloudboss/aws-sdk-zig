const MatterCapabilityReportAttribute = @import("matter_capability_report_attribute.zig").MatterCapabilityReportAttribute;

/// Capability used in Matter capability report.
pub const MatterCapabilityReportCluster = struct {
    /// The attributes of the Amazon Web Services Matter capability report.
    attributes: ?[]const MatterCapabilityReportAttribute = null,

    /// The commands used with the Amazon Web Services Matter capability report.
    commands: ?[]const []const u8 = null,

    /// The events used with the Amazon Web Services Matter capability report.
    events: ?[]const []const u8 = null,

    /// The fabric index for the Amazon Web Services Matter capability report.
    fabric_index: ?i32 = null,

    /// 32 bit-map used to indicate which features a cluster supports.
    feature_map: ?i64 = null,

    /// Matter clusters used in capability report.
    generated_commands: ?[]const []const u8 = null,

    /// The id of the Amazon Web Services Matter capability report cluster.
    id: []const u8,

    /// The capability name used in the Amazon Web Services Matter capability
    /// report.
    name: ?[]const u8 = null,

    /// The id of the schema version.
    public_id: ?[]const u8 = null,

    /// The id of the revision for the Amazon Web Services Matter capability report.
    revision: i32,

    /// The spec version used in the Amazon Web Services Matter capability report.
    spec_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .commands = "commands",
        .events = "events",
        .fabric_index = "fabricIndex",
        .feature_map = "featureMap",
        .generated_commands = "generatedCommands",
        .id = "id",
        .name = "name",
        .public_id = "publicId",
        .revision = "revision",
        .spec_version = "specVersion",
    };
};
