const LimitUnit = @import("limit_unit.zig").LimitUnit;
const ResourceType = @import("resource_type.zig").ResourceType;
const LimitSource = @import("limit_source.zig").LimitSource;

/// The effective limit for a resource type that applies to a user, considering
/// all applicable profile assignments and inheritance rules.
pub const EffectiveLimit = struct {
    /// The unit of measurement for the limit.
    limit_unit: LimitUnit,

    /// The maximum allowed value for the resource.
    limit_value: i64,

    /// The identifier of the limits profile that defines this limit.
    profile_id: []const u8,

    /// The type of resource that the limit applies to.
    resource_type: ResourceType,

    /// The source from which this limit was inherited. Possible values:
    ///
    /// * `DIRECT_USER` – The limit comes from a profile directly assigned to the
    ///   user.
    ///
    /// * `GROUP` – The limit comes from a profile assigned to a group the user
    ///   belongs to.
    ///
    /// * `ROLE` – The limit comes from a profile assigned to a role the user has.
    ///
    /// * `ACCOUNT` – The limit comes from the account-level default profile.
    ///
    /// * `SYSTEM_DEFAULT` – The limit comes from the built-in system default.
    source: LimitSource,

    pub const json_field_names = .{
        .limit_unit = "limitUnit",
        .limit_value = "limitValue",
        .profile_id = "profileId",
        .resource_type = "resourceType",
        .source = "source",
    };
};
