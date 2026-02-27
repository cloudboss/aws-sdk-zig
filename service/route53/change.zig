const ChangeAction = @import("change_action.zig").ChangeAction;
const ResourceRecordSet = @import("resource_record_set.zig").ResourceRecordSet;

/// The information for each resource record set that you want to change.
pub const Change = struct {
    /// The action to perform:
    ///
    /// * `CREATE`: Creates a resource record set that has the specified
    /// values.
    ///
    /// * `DELETE`: Deletes a existing resource record set.
    ///
    /// To delete the resource record set that is associated with a traffic policy
    /// instance, use
    /// [DeleteTrafficPolicyInstance](https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeleteTrafficPolicyInstance.html). Amazon Route 53 will delete the
    /// resource record set automatically. If you delete the resource record set by
    /// using `ChangeResourceRecordSets`, Route 53 doesn't automatically
    /// delete the traffic policy instance, and you'll continue to be charged for it
    /// even though it's no longer in use.
    ///
    /// * `UPSERT`: If a resource record set doesn't already exist, Route 53
    /// creates it. If a resource record set does exist, Route 53 updates it with
    /// the
    /// values in the request.
    action: ChangeAction,

    /// Information about the resource record set to create, delete, or update.
    resource_record_set: ResourceRecordSet,
};
