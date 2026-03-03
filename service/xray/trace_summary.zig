const aws = @import("aws");

const ValueWithServiceIds = @import("value_with_service_ids.zig").ValueWithServiceIds;
const AvailabilityZoneDetail = @import("availability_zone_detail.zig").AvailabilityZoneDetail;
const ServiceId = @import("service_id.zig").ServiceId;
const ErrorRootCause = @import("error_root_cause.zig").ErrorRootCause;
const FaultRootCause = @import("fault_root_cause.zig").FaultRootCause;
const Http = @import("http.zig").Http;
const InstanceIdDetail = @import("instance_id_detail.zig").InstanceIdDetail;
const ResourceARNDetail = @import("resource_arn_detail.zig").ResourceARNDetail;
const ResponseTimeRootCause = @import("response_time_root_cause.zig").ResponseTimeRootCause;
const TraceUser = @import("trace_user.zig").TraceUser;

/// Metadata generated from the segment documents in a trace.
pub const TraceSummary = struct {
    /// Annotations from the trace's segment documents.
    annotations: ?[]const aws.map.MapEntry([]const ValueWithServiceIds) = null,

    /// A list of Availability Zones for any zone corresponding to the trace
    /// segments.
    availability_zones: ?[]const AvailabilityZoneDetail = null,

    /// The length of time in seconds between the start time of the earliest segment
    /// that started and the end time of the last segment that completed.
    duration: ?f64 = null,

    /// The root of a trace.
    entry_point: ?ServiceId = null,

    /// A collection of ErrorRootCause structures corresponding to the trace
    /// segments.
    error_root_causes: ?[]const ErrorRootCause = null,

    /// A collection of FaultRootCause structures corresponding to the trace
    /// segments.
    fault_root_causes: ?[]const FaultRootCause = null,

    /// The root segment document has a 400 series error.
    has_error: ?bool = null,

    /// The root segment document has a 500 series error.
    has_fault: ?bool = null,

    /// One or more of the segment documents has a 429 throttling error.
    has_throttle: ?bool = null,

    /// Information about the HTTP request served by the trace.
    http: ?Http = null,

    /// The unique identifier for the request that generated the trace's segments
    /// and
    /// subsegments.
    id: ?[]const u8 = null,

    /// A list of EC2 instance IDs for any instance corresponding to the trace
    /// segments.
    instance_ids: ?[]const InstanceIdDetail = null,

    /// One or more of the segment documents is in progress.
    is_partial: ?bool = null,

    /// The matched time stamp of a defined event.
    matched_event_time: ?i64 = null,

    /// A list of resource ARNs for any resource corresponding to the trace
    /// segments.
    resource_ar_ns: ?[]const ResourceARNDetail = null,

    /// The length of time in seconds between the start and end times of the root
    /// segment. If
    /// the service performs work asynchronously, the response time measures the
    /// time before the
    /// response is sent to the user, while the duration measures the amount of time
    /// before the last
    /// traced activity completes.
    response_time: ?f64 = null,

    /// A collection of ResponseTimeRootCause structures corresponding to the trace
    /// segments.
    response_time_root_causes: ?[]const ResponseTimeRootCause = null,

    /// The revision number of a trace.
    revision: i32 = 0,

    /// Service IDs from the trace's segment documents.
    service_ids: ?[]const ServiceId = null,

    /// The start time of a trace, based on the earliest trace segment start time.
    start_time: ?i64 = null,

    /// Users from the trace's segment documents.
    users: ?[]const TraceUser = null,

    pub const json_field_names = .{
        .annotations = "Annotations",
        .availability_zones = "AvailabilityZones",
        .duration = "Duration",
        .entry_point = "EntryPoint",
        .error_root_causes = "ErrorRootCauses",
        .fault_root_causes = "FaultRootCauses",
        .has_error = "HasError",
        .has_fault = "HasFault",
        .has_throttle = "HasThrottle",
        .http = "Http",
        .id = "Id",
        .instance_ids = "InstanceIds",
        .is_partial = "IsPartial",
        .matched_event_time = "MatchedEventTime",
        .resource_ar_ns = "ResourceARNs",
        .response_time = "ResponseTime",
        .response_time_root_causes = "ResponseTimeRootCauses",
        .revision = "Revision",
        .service_ids = "ServiceIds",
        .start_time = "StartTime",
        .users = "Users",
    };
};
