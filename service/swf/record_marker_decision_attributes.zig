/// Provides the details of the `RecordMarker` decision.
///
/// **Access Control**
///
/// You can use IAM policies to control this decision's access to Amazon SWF
/// resources as follows:
///
/// * Use a `Resource` element with the domain name to limit the action to only
/// specified domains.
///
/// * Use an `Action` element to allow or deny permission to call this action.
///
/// * You cannot use an IAM policy to constrain this action's parameters.
///
/// If the caller doesn't have sufficient permissions to invoke the action, or
/// the
/// parameter values fall outside the specified constraints, the action fails.
/// The associated event attribute's
/// `cause` parameter is set to `OPERATION_NOT_PERMITTED`. For details and
/// example IAM policies, see
/// [Using IAM to Manage Access to Amazon SWF
/// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
pub const RecordMarkerDecisionAttributes = struct {
    /// The details of the marker.
    details: ?[]const u8 = null,

    /// The name of the marker.
    marker_name: []const u8,

    pub const json_field_names = .{
        .details = "details",
        .marker_name = "markerName",
    };
};
