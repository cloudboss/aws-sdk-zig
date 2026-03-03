const Entity = @import("entity.zig").Entity;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// This object is a container for common summary information about the change.
/// The
/// summary doesn't contain the whole change structure.
pub const ChangeSummary = struct {
    /// Optional name for the change.
    change_name: ?[]const u8 = null,

    /// The type of the change.
    change_type: ?[]const u8 = null,

    /// This object contains details specific to the change type of the requested
    /// change.
    details: ?[]const u8 = null,

    /// The JSON value of the details specific to the change type of the requested
    /// change.
    ///
    /// To download the "DetailsDocument" shapes, see the
    /// [Python](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-python)
    /// and
    /// [Java](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-java/tree/main) shapes on GitHub.
    details_document: ?[]const u8 = null,

    /// The entity to be changed.
    entity: ?Entity = null,

    /// An array of `ErrorDetail` objects associated with the change.
    error_detail_list: ?[]const ErrorDetail = null,

    pub const json_field_names = .{
        .change_name = "ChangeName",
        .change_type = "ChangeType",
        .details = "Details",
        .details_document = "DetailsDocument",
        .entity = "Entity",
        .error_detail_list = "ErrorDetailList",
    };
};
