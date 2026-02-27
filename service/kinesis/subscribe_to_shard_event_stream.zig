const InternalFailureException = @import("internal_failure_exception.zig").InternalFailureException;
const KMSAccessDeniedException = @import("kms_access_denied_exception.zig").KMSAccessDeniedException;
const KMSDisabledException = @import("kms_disabled_exception.zig").KMSDisabledException;
const KMSInvalidStateException = @import("kms_invalid_state_exception.zig").KMSInvalidStateException;
const KMSNotFoundException = @import("kms_not_found_exception.zig").KMSNotFoundException;
const KMSOptInRequired = @import("kms_opt_in_required.zig").KMSOptInRequired;
const KMSThrottlingException = @import("kms_throttling_exception.zig").KMSThrottlingException;
const ResourceInUseException = @import("resource_in_use_exception.zig").ResourceInUseException;
const ResourceNotFoundException = @import("resource_not_found_exception.zig").ResourceNotFoundException;
const SubscribeToShardEvent = @import("subscribe_to_shard_event.zig").SubscribeToShardEvent;

/// This is a tagged union for all of the types of events an enhanced fan-out
/// consumer can
/// receive over HTTP/2 after a call to SubscribeToShard.
pub const SubscribeToShardEventStream = union(enum) {
    /// The processing of the request failed because of an unknown error, exception,
    /// or
    /// failure.
    internal_failure_exception: ?InternalFailureException,
    kms_access_denied_exception: ?KMSAccessDeniedException,
    kms_disabled_exception: ?KMSDisabledException,
    kms_invalid_state_exception: ?KMSInvalidStateException,
    kms_not_found_exception: ?KMSNotFoundException,
    kms_opt_in_required: ?KMSOptInRequired,
    kms_throttling_exception: ?KMSThrottlingException,
    resource_in_use_exception: ?ResourceInUseException,
    resource_not_found_exception: ?ResourceNotFoundException,
    /// After you call SubscribeToShard, Kinesis Data Streams sends events
    /// of this type to your consumer. For an example of how to handle these events,
    /// see [Enhanced Fan-Out
    /// Using the Kinesis Data Streams
    /// API](/streams/latest/dev/building-enhanced-consumers-api.html).
    subscribe_to_shard_event: ?SubscribeToShardEvent,

    pub const json_field_names = .{
        .internal_failure_exception = "InternalFailureException",
        .kms_access_denied_exception = "KMSAccessDeniedException",
        .kms_disabled_exception = "KMSDisabledException",
        .kms_invalid_state_exception = "KMSInvalidStateException",
        .kms_not_found_exception = "KMSNotFoundException",
        .kms_opt_in_required = "KMSOptInRequired",
        .kms_throttling_exception = "KMSThrottlingException",
        .resource_in_use_exception = "ResourceInUseException",
        .resource_not_found_exception = "ResourceNotFoundException",
        .subscribe_to_shard_event = "SubscribeToShardEvent",
    };
};
