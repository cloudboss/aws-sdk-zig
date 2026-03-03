/// Details about the polling configuration for the `JobWorker` action engine,
/// or executor.
pub const JobWorkerExecutorConfiguration = struct {
    /// The accounts in which the job worker is configured and might poll for jobs
    /// as part of
    /// the action execution.
    polling_accounts: ?[]const []const u8 = null,

    /// The service Principals in which the job worker is configured and might poll
    /// for jobs
    /// as part of the action execution.
    polling_service_principals: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .polling_accounts = "pollingAccounts",
        .polling_service_principals = "pollingServicePrincipals",
    };
};
