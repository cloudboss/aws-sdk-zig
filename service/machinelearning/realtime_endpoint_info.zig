const RealtimeEndpointStatus = @import("realtime_endpoint_status.zig").RealtimeEndpointStatus;

/// Describes the real-time endpoint information for an `MLModel`.
pub const RealtimeEndpointInfo = struct {
    /// The time that the request to create the real-time endpoint for the `MLModel`
    /// was received. The time is expressed in epoch time.
    created_at: ?i64,

    /// The current status of the real-time endpoint for the `MLModel`. This element
    /// can have one of the following values:
    ///
    /// * `NONE` - Endpoint does not exist or was previously deleted.
    ///
    /// * `READY` - Endpoint is ready to be used for real-time predictions.
    ///
    /// * `UPDATING` - Updating/creating the endpoint.
    endpoint_status: ?RealtimeEndpointStatus,

    /// The URI that specifies where to send real-time prediction requests for the
    /// `MLModel`.
    ///
    /// **Note:** The application must wait until the real-time endpoint is ready
    /// before using this URI.
    endpoint_url: ?[]const u8,

    /// The maximum processing rate for the real-time endpoint for `MLModel`,
    /// measured in incoming requests per second.
    peak_requests_per_second: i32 = 0,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .endpoint_status = "EndpointStatus",
        .endpoint_url = "EndpointUrl",
        .peak_requests_per_second = "PeakRequestsPerSecond",
    };
};
