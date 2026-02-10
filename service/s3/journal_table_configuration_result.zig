const ErrorDetails = @import("error_details.zig").ErrorDetails;
const RecordExpiration = @import("record_expiration.zig").RecordExpiration;

/// The journal table configuration for the S3 Metadata configuration.
pub const JournalTableConfigurationResult = struct {
    @"error": ?ErrorDetails,

    /// The journal table record expiration settings for the journal table.
    record_expiration: RecordExpiration,

    /// The Amazon Resource Name (ARN) for the journal table.
    table_arn: ?[]const u8,

    /// The name of the journal table.
    table_name: []const u8,

    /// The status of the journal table. The status values are:
    ///
    /// * `CREATING` - The journal table is in the process of being created in the
    ///   specified
    /// table bucket.
    ///
    /// * `ACTIVE` - The journal table has been created successfully, and records
    ///   are being
    /// delivered to the table.
    ///
    /// * `FAILED` - Amazon S3 is unable to create the journal table, or Amazon S3
    ///   is unable to deliver
    /// records.
    table_status: []const u8,
};
