const AcceptanceType = @import("acceptance_type.zig").AcceptanceType;
const PublishedState = @import("published_state.zig").PublishedState;
const UploadState = @import("upload_state.zig").UploadState;

/// Summary for report resource.
pub const ReportSummary = struct {
    /// Acceptance type for report.
    acceptance_type: ?AcceptanceType = null,

    /// ARN for the report resource.
    arn: ?[]const u8 = null,

    /// Category for the report resource.
    category: ?[]const u8 = null,

    /// Associated company name for the report resource.
    company_name: ?[]const u8 = null,

    /// Description for the report resource.
    description: ?[]const u8 = null,

    /// Unique resource ID for the report resource.
    id: ?[]const u8 = null,

    /// Name for the report resource.
    name: ?[]const u8 = null,

    /// Timestamp indicating the report resource effective end.
    period_end: ?i64 = null,

    /// Timestamp indicating the report resource effective start.
    period_start: ?i64 = null,

    /// Associated product name for the report resource.
    product_name: ?[]const u8 = null,

    /// Series for the report resource.
    series: ?[]const u8 = null,

    /// Current state of the report resource.
    state: ?PublishedState = null,

    /// The message associated with the current upload state.
    status_message: ?[]const u8 = null,

    /// The current state of the document upload.
    upload_state: ?UploadState = null,

    /// Version for the report resource.
    version: ?i64 = null,

    pub const json_field_names = .{
        .acceptance_type = "acceptanceType",
        .arn = "arn",
        .category = "category",
        .company_name = "companyName",
        .description = "description",
        .id = "id",
        .name = "name",
        .period_end = "periodEnd",
        .period_start = "periodStart",
        .product_name = "productName",
        .series = "series",
        .state = "state",
        .status_message = "statusMessage",
        .upload_state = "uploadState",
        .version = "version",
    };
};
