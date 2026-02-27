/// Describes the parameters of a no bid module.
pub const NoBidModuleParameters = struct {
    /// The pass through percentage.
    pass_through_percentage: ?f32,

    /// The reason description.
    reason: ?[]const u8,

    /// The reason code.
    reason_code: ?i32,

    pub const json_field_names = .{
        .pass_through_percentage = "passThroughPercentage",
        .reason = "reason",
        .reason_code = "reasonCode",
    };
};
