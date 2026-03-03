const InventoryRetrievalJobInput = @import("inventory_retrieval_job_input.zig").InventoryRetrievalJobInput;
const OutputLocation = @import("output_location.zig").OutputLocation;
const SelectParameters = @import("select_parameters.zig").SelectParameters;

/// Provides options for defining a job.
pub const JobParameters = struct {
    /// The ID of the archive that you want to retrieve. This field is required only
    /// if
    /// `Type` is set to `select` or `archive-retrieval`code>.
    /// An error occurs if you specify this
    /// request parameter for an inventory retrieval job request.
    archive_id: ?[]const u8 = null,

    /// The optional description for the job. The description must be less than or
    /// equal to
    /// 1,024 bytes. The allowable characters are 7-bit ASCII without control
    /// codes-specifically,
    /// ASCII values 32-126 decimal or 0x20-0x7E hexadecimal.
    description: ?[]const u8 = null,

    /// When initiating a job to retrieve a vault inventory, you can optionally add
    /// this
    /// parameter to your request to specify the output format. If you are
    /// initiating an inventory
    /// job and do not specify a Format field, JSON is the default format. Valid
    /// values are "CSV"
    /// and "JSON".
    format: ?[]const u8 = null,

    /// Input parameters used for range inventory retrieval.
    inventory_retrieval_parameters: ?InventoryRetrievalJobInput = null,

    /// Contains information about the location where the select job results are
    /// stored.
    output_location: ?OutputLocation = null,

    /// The byte range to retrieve for an archive retrieval. in the form
    /// "*StartByteValue*-*EndByteValue*" If not
    /// specified, the whole archive is retrieved. If specified, the byte range must
    /// be megabyte
    /// (1024*1024) aligned which means that *StartByteValue* must be divisible
    /// by 1 MB and *EndByteValue* plus 1 must be divisible by 1 MB or be the
    /// end of the archive specified as the archive byte size value minus 1. If
    /// RetrievalByteRange
    /// is not megabyte aligned, this operation returns a 400 response.
    ///
    /// An error occurs if you specify this field for an inventory retrieval job
    /// request.
    retrieval_byte_range: ?[]const u8 = null,

    /// Contains the parameters that define a job.
    select_parameters: ?SelectParameters = null,

    /// The Amazon SNS topic ARN to which Amazon Glacier sends a notification when
    /// the job is
    /// completed and the output is ready for you to download. The specified topic
    /// publishes the
    /// notification to its subscribers. The SNS topic must exist.
    sns_topic: ?[]const u8 = null,

    /// The tier to use for a select or an archive retrieval job. Valid values are
    /// `Expedited`, `Standard`, or `Bulk`.
    /// `Standard` is the default.
    tier: ?[]const u8 = null,

    /// The job type. You can initiate a job to perform a select query on an
    /// archive,
    /// retrieve an archive, or get an inventory of a vault.
    /// Valid values are "select", "archive-retrieval" and "inventory-retrieval".
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
        .description = "Description",
        .format = "Format",
        .inventory_retrieval_parameters = "InventoryRetrievalParameters",
        .output_location = "OutputLocation",
        .retrieval_byte_range = "RetrievalByteRange",
        .select_parameters = "SelectParameters",
        .sns_topic = "SNSTopic",
        .tier = "Tier",
        .@"type" = "Type",
    };
};
