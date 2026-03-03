const ClusterState = @import("cluster_state.zig").ClusterState;
const JobType = @import("job_type.zig").JobType;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingOption = @import("shipping_option.zig").ShippingOption;
const SnowballType = @import("snowball_type.zig").SnowballType;
const TaxDocuments = @import("tax_documents.zig").TaxDocuments;

/// Contains metadata about a specific cluster.
pub const ClusterMetadata = struct {
    /// The automatically generated ID for a specific address.
    address_id: ?[]const u8 = null,

    /// The automatically generated ID for a cluster.
    cluster_id: ?[]const u8 = null,

    /// The current status of the cluster.
    cluster_state: ?ClusterState = null,

    /// The creation date for this cluster.
    creation_date: ?i64 = null,

    /// The optional description of the cluster.
    description: ?[]const u8 = null,

    /// The ID of the address that you want a cluster shipped to, after it will be
    /// shipped to its primary address. This field is not supported in most regions.
    forwarding_address_id: ?[]const u8 = null,

    /// The type of job for this cluster. Currently, the only job type supported for
    /// clusters
    /// is `LOCAL_USE`.
    job_type: ?JobType = null,

    /// The `KmsKeyARN` Amazon Resource Name (ARN) associated with this cluster.
    /// This ARN was created using the
    /// [CreateKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateKey.html) API action in Key Management Service (KMS.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Simple Notification Service (Amazon SNS) notification settings
    /// for this
    /// cluster.
    notification: ?Notification = null,

    /// Represents metadata and configuration settings for services on an Amazon Web
    /// Services Snow Family
    /// device.
    on_device_service_configuration: ?OnDeviceServiceConfiguration = null,

    /// The arrays of JobResource objects that can include updated S3Resource
    /// objects or LambdaResource objects.
    resources: ?JobResource = null,

    /// The role ARN associated with this cluster. This ARN was created using the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html)
    /// API action in Identity and Access Management (IAM).
    role_arn: ?[]const u8 = null,

    /// The shipping speed for each node in this cluster. This speed doesn't dictate
    /// how soon
    /// you'll get each device, rather it represents how quickly each device moves
    /// to its destination
    /// while in transit. Regional shipping speeds are as follows:
    ///
    /// * In Australia, you have access to express shipping. Typically, devices
    ///   shipped
    /// express are delivered in about a day.
    ///
    /// * In the European Union (EU), you have access to express shipping.
    ///   Typically, Snow
    /// devices shipped express are delivered in about a day. In addition, most
    /// countries in the
    /// EU have access to standard shipping, which typically takes less than a week,
    /// one
    /// way.
    ///
    /// * In India, Snow devices are delivered in one to seven days.
    ///
    /// * In the US, you have access to one-day shipping and two-day shipping.
    shipping_option: ?ShippingOption = null,

    /// The type of Snowball Edge device to use for this cluster.
    ///
    /// For cluster jobs, Amazon Web Services Snow Family currently supports only
    /// the
    /// `EDGE` device type.
    snowball_type: ?SnowballType = null,

    /// The tax documents required in your Amazon Web Services Region.
    tax_documents: ?TaxDocuments = null,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .cluster_id = "ClusterId",
        .cluster_state = "ClusterState",
        .creation_date = "CreationDate",
        .description = "Description",
        .forwarding_address_id = "ForwardingAddressId",
        .job_type = "JobType",
        .kms_key_arn = "KmsKeyARN",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_option = "ShippingOption",
        .snowball_type = "SnowballType",
        .tax_documents = "TaxDocuments",
    };
};
