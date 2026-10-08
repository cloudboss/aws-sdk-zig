const DataArtifact = @import("data_artifact.zig").DataArtifact;
const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;

/// Describes an AWS Data Exchange fulfillment option for data set delivery.
pub const DataExchangeFulfillmentOption = struct {
    /// The data artifacts included in this Data Exchange fulfillment option.
    data_artifacts: ?[]const DataArtifact = null,

    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    pub const json_field_names = .{
        .data_artifacts = "dataArtifacts",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
    };
};
