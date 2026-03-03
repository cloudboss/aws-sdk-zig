const Unit = @import("unit.zig").Unit;

/// Specifies a current quota for an Amazon Macie account.
pub const ServiceLimit = struct {
    /// Specifies whether the account has met the quota that corresponds to the
    /// metric specified by the UsageByAccount.type field in the response.
    is_service_limited: ?bool = null,

    /// The unit of measurement for the value specified by the value field.
    unit: ?Unit = null,

    /// The value for the metric specified by the UsageByAccount.type field in the
    /// response.
    value: ?i64 = null,

    pub const json_field_names = .{
        .is_service_limited = "isServiceLimited",
        .unit = "unit",
        .value = "value",
    };
};
