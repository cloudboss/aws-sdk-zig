/// Provides information about a specific limit.
pub const LimitSummary = struct {
    /// The value that you specify as the `name` in the `amounts` field of the
    /// `hostRequirements` in a step of a job template to declare the limit
    /// requirement.
    amount_requirement_name: []const u8,

    /// The Unix timestamp of the date and time that the limit was created.
    created_at: i64,

    /// The user identifier of the person that created the limit.
    created_by: []const u8,

    /// The number of resources from the limit that are being used by jobs. The
    /// result is delayed and may not be the count at the time that you called the
    /// operation.
    current_count: i32,

    /// The name of the limit used in lists to identify the limit.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The unique identifier of the farm that contains the limit.
    farm_id: []const u8,

    /// The unique identifier of the limit.
    limit_id: []const u8,

    /// The maximum number of resources constrained by this limit. When all of the
    /// resources are in use, steps that require the limit won't be scheduled until
    /// the resource is available.
    ///
    /// The `maxValue` must not be 0. If the value is -1, there is no restriction on
    /// the number of resources that can be acquired for this limit.
    max_count: i32,

    /// The Unix timestamp of the date and time that the limit was last updated.
    updated_at: ?i64,

    /// The user identifier of the person that last updated the limit.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .amount_requirement_name = "amountRequirementName",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .current_count = "currentCount",
        .display_name = "displayName",
        .farm_id = "farmId",
        .limit_id = "limitId",
        .max_count = "maxCount",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
