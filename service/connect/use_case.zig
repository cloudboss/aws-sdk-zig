const UseCaseType = @import("use_case_type.zig").UseCaseType;

/// Contains the
/// use
/// case.
pub const UseCase = struct {
    /// The Amazon Resource Name (ARN) for the use case.
    use_case_arn: ?[]const u8 = null,

    /// The identifier for the use case.
    use_case_id: ?[]const u8 = null,

    /// The type of use case to associate to the integration association. Each
    /// integration association can have only one
    /// of each use case type.
    use_case_type: ?UseCaseType = null,

    pub const json_field_names = .{
        .use_case_arn = "UseCaseArn",
        .use_case_id = "UseCaseId",
        .use_case_type = "UseCaseType",
    };
};
