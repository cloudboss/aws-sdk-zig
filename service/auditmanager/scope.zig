const AWSAccount = @import("aws_account.zig").AWSAccount;
const AWSService = @import("aws_service.zig").AWSService;

/// The wrapper that contains the Amazon Web Services accounts that are in
/// scope for the assessment.
///
/// You no longer need to specify which Amazon Web Services services are in
/// scope when you
/// create or update an assessment. Audit Manager infers the services in scope
/// by
/// examining your assessment controls and their data sources, and then mapping
/// this
/// information to the relevant Amazon Web Services services.
///
/// If an underlying data source changes for your assessment, we automatically
/// update the
/// services scope as needed to reflect the correct Amazon Web Services
/// services. This
/// ensures that your assessment collects accurate and comprehensive evidence
/// about all of
/// the relevant services in your AWS environment.
pub const Scope = struct {
    /// The Amazon Web Services accounts that are included in the scope of the
    /// assessment.
    aws_accounts: ?[]const AWSAccount,

    /// The Amazon Web Services services that are included in the scope of the
    /// assessment.
    ///
    /// This API parameter is no longer supported. If you use this parameter to
    /// specify one
    /// or more Amazon Web Services services, Audit Manager ignores this input.
    /// Instead, the
    /// value for `awsServices` will show as empty.
    aws_services: ?[]const AWSService,

    pub const json_field_names = .{
        .aws_accounts = "awsAccounts",
        .aws_services = "awsServices",
    };
};
