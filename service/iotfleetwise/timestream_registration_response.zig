const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// Information about the registered Amazon Timestream resources or errors, if
/// any.
pub const TimestreamRegistrationResponse = struct {
    /// A message associated with a registration error.
    error_message: ?[]const u8,

    /// The status of registering your Amazon Timestream resources. The status can
    /// be one of
    /// `REGISTRATION_SUCCESS`, `REGISTRATION_PENDING`,
    /// `REGISTRATION_FAILURE`.
    registration_status: RegistrationStatus,

    /// The Amazon Resource Name (ARN) of the Timestream database.
    timestream_database_arn: ?[]const u8,

    /// The name of the Timestream database.
    timestream_database_name: []const u8,

    /// The ARN of the Timestream database table.
    timestream_table_arn: ?[]const u8,

    /// The name of the Timestream database table.
    timestream_table_name: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .registration_status = "registrationStatus",
        .timestream_database_arn = "timestreamDatabaseArn",
        .timestream_database_name = "timestreamDatabaseName",
        .timestream_table_arn = "timestreamTableArn",
        .timestream_table_name = "timestreamTableName",
    };
};
