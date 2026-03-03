/// Describes the error when an experiment has `failed`.
pub const ExperimentError = struct {
    /// The Amazon Web Services Account ID where the experiment failure occurred.
    account_id: ?[]const u8 = null,

    /// The error code for the failed experiment.
    code: ?[]const u8 = null,

    /// Context for the section of the experiment template that failed.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .code = "code",
        .location = "location",
    };
};
