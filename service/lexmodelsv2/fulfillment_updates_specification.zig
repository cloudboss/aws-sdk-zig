const FulfillmentStartResponseSpecification = @import("fulfillment_start_response_specification.zig").FulfillmentStartResponseSpecification;
const FulfillmentUpdateResponseSpecification = @import("fulfillment_update_response_specification.zig").FulfillmentUpdateResponseSpecification;

/// Provides information for updating the user on the progress of
/// fulfilling an intent.
pub const FulfillmentUpdatesSpecification = struct {
    /// Determines whether fulfillment updates are sent to the user. When
    /// this field is true, updates are sent.
    ///
    /// If the `active` field is set to true, the
    /// `startResponse`, `updateResponse`, and
    /// `timeoutInSeconds` fields are required.
    active: bool,

    /// Provides configuration information for the message sent to users
    /// when the fulfillment Lambda functions starts running.
    start_response: ?FulfillmentStartResponseSpecification = null,

    /// The length of time that the fulfillment Lambda function should run
    /// before it times out.
    timeout_in_seconds: ?i32 = null,

    /// Provides configuration information for messages sent periodically to
    /// the user while the fulfillment Lambda function is running.
    update_response: ?FulfillmentUpdateResponseSpecification = null,

    pub const json_field_names = .{
        .active = "active",
        .start_response = "startResponse",
        .timeout_in_seconds = "timeoutInSeconds",
        .update_response = "updateResponse",
    };
};
