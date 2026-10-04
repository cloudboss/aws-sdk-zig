const LimitDefinitionType = @import("limit_definition_type.zig").LimitDefinitionType;

/// The limit definition and current limit values for a provisioned limit.
pub const LimitType = struct {
    /// The default (free) limit value, in requests per second (RPS). This is the
    /// rate
    /// included at no additional cost.
    free_limit_value: i32 = 0,

    /// The definition that identifies this limit, including the class and
    /// attributes.
    limit_definition: LimitDefinitionType,

    /// The provisioned limit value, in requests per second (RPS). This is the rate
    /// that
    /// Amazon Cognito currently enforces for your account.
    provisioned_limit_value: i32 = 0,

    pub const json_field_names = .{
        .free_limit_value = "FreeLimitValue",
        .limit_definition = "LimitDefinition",
        .provisioned_limit_value = "ProvisionedLimitValue",
    };
};
