const TargetIdType = @import("target_id_type.zig").TargetIdType;

/// A count of noncompliant resources.
pub const Summary = struct {
    /// The timestamp that shows when this summary was generated in this Region.
    last_updated: ?[]const u8 = null,

    /// The count of noncompliant resources.
    non_compliant_resources: i64 = 0,

    /// The Amazon Web Services Region that the summary applies to.
    region: ?[]const u8 = null,

    /// The Amazon Web Services resource type.
    resource_type: ?[]const u8 = null,

    /// The account identifier or the root identifier of the organization. If you
    /// don't know
    /// the root ID, you can call the Organizations
    /// [ListRoots](https://docs.aws.amazon.com/organizations/latest/APIReference/API_ListRoots.html) API.
    target_id: ?[]const u8 = null,

    /// Whether the target is an account, an OU, or the organization root.
    target_id_type: ?TargetIdType = null,

    pub const json_field_names = .{
        .last_updated = "LastUpdated",
        .non_compliant_resources = "NonCompliantResources",
        .region = "Region",
        .resource_type = "ResourceType",
        .target_id = "TargetId",
        .target_id_type = "TargetIdType",
    };
};
