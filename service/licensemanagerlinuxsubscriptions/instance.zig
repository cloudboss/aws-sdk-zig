/// Details discovered information about a running instance using Linux
/// subscriptions.
pub const Instance = struct {
    /// The account ID which owns the instance.
    account_id: ?[]const u8 = null,

    /// The AMI ID used to launch the instance.
    ami_id: ?[]const u8 = null,

    /// Indicates that you have two different license subscriptions for
    /// the same software on your instance.
    dual_subscription: ?[]const u8 = null,

    /// The instance ID of the resource.
    instance_id: ?[]const u8 = null,

    /// The instance type of the resource.
    instance_type: ?[]const u8 = null,

    /// The time in which the last discovery updated the instance details.
    last_updated_time: ?[]const u8 = null,

    /// The operating system software version that runs on your instance.
    os_version: ?[]const u8 = null,

    /// The product code for the instance. For more information, see [Usage
    /// operation
    /// values](https://docs.aws.amazon.com/license-manager/latest/userguide/linux-subscriptions-usage-operation.html) in the *License Manager User Guide* .
    product_code: ?[]const []const u8 = null,

    /// The Region the instance is running in.
    region: ?[]const u8 = null,

    /// Indicates that your instance uses a BYOL license subscription from
    /// a third-party Linux subscription provider that you've registered with
    /// License Manager.
    registered_with_subscription_provider: ?[]const u8 = null,

    /// The status of the instance.
    status: ?[]const u8 = null,

    /// The name of the license subscription that the instance uses.
    subscription_name: ?[]const u8 = null,

    /// The timestamp when you registered the third-party Linux subscription
    /// provider for the subscription that the instance uses.
    subscription_provider_create_time: ?[]const u8 = null,

    /// The timestamp from the last time that the instance synced with the
    /// registered
    /// third-party Linux subscription provider.
    subscription_provider_update_time: ?[]const u8 = null,

    /// The usage operation of the instance. For more information, see For more
    /// information, see
    /// [Usage
    /// operation
    /// values](https://docs.aws.amazon.com/license-manager/latest/userguide/linux-subscriptions-usage-operation.html) in the *License Manager User Guide*.
    usage_operation: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountID",
        .ami_id = "AmiId",
        .dual_subscription = "DualSubscription",
        .instance_id = "InstanceID",
        .instance_type = "InstanceType",
        .last_updated_time = "LastUpdatedTime",
        .os_version = "OsVersion",
        .product_code = "ProductCode",
        .region = "Region",
        .registered_with_subscription_provider = "RegisteredWithSubscriptionProvider",
        .status = "Status",
        .subscription_name = "SubscriptionName",
        .subscription_provider_create_time = "SubscriptionProviderCreateTime",
        .subscription_provider_update_time = "SubscriptionProviderUpdateTime",
        .usage_operation = "UsageOperation",
    };
};
