/// Provides information about the Explainability resource.
pub const ExplainabilityInfo = struct {
    /// The Amazon Resource Name (ARN) of the Explainability.
    explainability_arn: ?[]const u8,

    /// The status of the Explainability. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    status: ?[]const u8,

    pub const json_field_names = .{
        .explainability_arn = "ExplainabilityArn",
        .status = "Status",
    };
};
