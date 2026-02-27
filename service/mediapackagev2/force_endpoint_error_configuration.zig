const EndpointErrorCondition = @import("endpoint_error_condition.zig").EndpointErrorCondition;

/// The failover settings for the endpoint.
pub const ForceEndpointErrorConfiguration = struct {
    /// The failover conditions for the endpoint. The options are:
    ///
    /// * `STALE_MANIFEST` - The manifest stalled and there are no new segments or
    ///   parts.
    /// * `INCOMPLETE_MANIFEST` - There is a gap in the manifest.
    /// * `MISSING_DRM_KEY` - Key rotation is enabled but we're unable to fetch the
    ///   key for the current key period.
    /// * `SLATE_INPUT` - The segments which contain slate content are considered to
    ///   be missing content.
    endpoint_error_conditions: ?[]const EndpointErrorCondition,

    pub const json_field_names = .{
        .endpoint_error_conditions = "EndpointErrorConditions",
    };
};
