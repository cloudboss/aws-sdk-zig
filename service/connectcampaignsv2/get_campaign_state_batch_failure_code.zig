/// A predefined code indicating the error that caused the failure in getting
/// state of campaigns
pub const GetCampaignStateBatchFailureCode = enum {
    /// The specified resource was not found
    resource_not_found,
    /// Unexpected error during processing of request
    unknown_error,

    pub const json_field_names = .{
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .unknown_error = "UNKNOWN_ERROR",
    };
};
