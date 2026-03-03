const ArchitectureValues = @import("architecture_values.zig").ArchitectureValues;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const BootModeValues = @import("boot_mode_values.zig").BootModeValues;
const HypervisorType = @import("hypervisor_type.zig").HypervisorType;
const ImageTypeValues = @import("image_type_values.zig").ImageTypeValues;
const ImdsSupportValues = @import("imds_support_values.zig").ImdsSupportValues;
const PlatformValues = @import("platform_values.zig").PlatformValues;
const ProductCode = @import("product_code.zig").ProductCode;
const DeviceType = @import("device_type.zig").DeviceType;
const ImageState = @import("image_state.zig").ImageState;
const StateReason = @import("state_reason.zig").StateReason;
const Tag = @import("tag.zig").Tag;
const TpmSupportValues = @import("tpm_support_values.zig").TpmSupportValues;
const VirtualizationType = @import("virtualization_type.zig").VirtualizationType;

/// Describes an image.
pub const Image = struct {
    /// The architecture of the image.
    architecture: ?ArchitectureValues = null,

    /// Any block device mapping entries.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// The boot mode of the image. For more information, see [Instance launch
    /// behavior with Amazon EC2
    /// boot
    /// modes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-boot.html) in
    /// the *Amazon EC2 User Guide*.
    boot_mode: ?BootModeValues = null,

    /// The date and time the image was created.
    creation_date: ?[]const u8 = null,

    /// The date and time to deprecate the AMI, in UTC, in the following format:
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z.
    /// If you specified a value for seconds, Amazon EC2 rounds the seconds to the
    /// nearest minute.
    deprecation_time: ?[]const u8 = null,

    /// Indicates whether deregistration protection is enabled for the AMI.
    deregistration_protection: ?[]const u8 = null,

    /// The description of the AMI that was provided during image creation.
    description: ?[]const u8 = null,

    /// Specifies whether enhanced networking with ENA is enabled.
    ena_support: ?bool = null,

    /// Indicates whether the image is eligible for Amazon Web Services Free Tier.
    ///
    /// * If `true`, the AMI is eligible for Free Tier and can be used to launch
    /// instances under the Free Tier limits.
    ///
    /// * If `false`, the AMI is not eligible for Free Tier.
    free_tier_eligible: ?bool = null,

    /// The hypervisor type of the image. Only `xen` is supported. `ovm` is
    /// not supported.
    hypervisor: ?HypervisorType = null,

    /// If `true`, the AMI satisfies the criteria for Allowed AMIs and can be
    /// discovered and used in the account. If `false` and Allowed AMIs is set to
    /// `enabled`, the AMI can't be discovered or used in the account. If
    /// `false` and Allowed AMIs is set to `audit-mode`, the AMI can be
    /// discovered and used in the account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    image_allowed: ?bool = null,

    /// The ID of the AMI.
    image_id: ?[]const u8 = null,

    /// The location of the AMI.
    image_location: ?[]const u8 = null,

    /// The owner alias (`amazon` | `aws-backup-vault` |
    /// `aws-marketplace`).
    image_owner_alias: ?[]const u8 = null,

    /// The type of image.
    image_type: ?ImageTypeValues = null,

    /// If `v2.0`, it indicates that IMDSv2 is specified in the AMI. Instances
    /// launched
    /// from this AMI will have `HttpTokens` automatically set to `required` so
    /// that, by default, the instance requires that IMDSv2 is used when requesting
    /// instance metadata.
    /// In addition, `HttpPutResponseHopLimit` is set to `2`. For more
    /// information, see [Configure the
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#configure-IMDS-new-instances-ami-configuration) in the *Amazon EC2 User Guide*.
    imds_support: ?ImdsSupportValues = null,

    /// The kernel associated with the image, if any. Only applicable for machine
    /// images.
    kernel_id: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the AMI was last used to
    /// launch an EC2 instance. When the AMI is used
    /// to launch an instance, there is a 24-hour delay before that usage is
    /// reported.
    ///
    /// `lastLaunchedTime` data is available starting April 2017.
    last_launched_time: ?[]const u8 = null,

    /// The name of the AMI that was provided during image creation.
    name: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the image.
    owner_id: ?[]const u8 = null,

    /// This value is set to `windows` for Windows AMIs; otherwise, it is blank.
    platform: ?PlatformValues = null,

    /// The platform details associated with the billing code of the AMI. For more
    /// information,
    /// see [Understand
    /// AMI billing
    /// information](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-billing-info.html) in the *Amazon EC2 User Guide*.
    platform_details: ?[]const u8 = null,

    /// Any product codes associated with the AMI.
    product_codes: ?[]const ProductCode = null,

    /// Indicates whether the image has public launch permissions. The value is
    /// `true`
    /// if this image has public launch permissions or `false` if it has only
    /// implicit and
    /// explicit launch permissions.
    public: ?bool = null,

    /// The RAM disk associated with the image, if any. Only applicable for machine
    /// images.
    ramdisk_id: ?[]const u8 = null,

    /// The device name of the root device volume (for example, `/dev/sda1`).
    root_device_name: ?[]const u8 = null,

    /// The type of root device used by the AMI. The AMI can use an Amazon EBS
    /// volume or an instance
    /// store volume.
    root_device_type: ?DeviceType = null,

    /// The ID of the source AMI from which the AMI was created.
    source_image_id: ?[]const u8 = null,

    /// The Region of the source AMI.
    source_image_region: ?[]const u8 = null,

    /// The ID of the instance that the AMI was created from if the AMI was created
    /// using
    /// [CreateImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateImage.html). This field only appears if the AMI was created using
    /// CreateImage.
    source_instance_id: ?[]const u8 = null,

    /// Specifies whether enhanced networking with the Intel 82599 Virtual Function
    /// interface is
    /// enabled.
    sriov_net_support: ?[]const u8 = null,

    /// The current state of the AMI. If the state is `available`, the image is
    /// successfully registered and can be used to launch an instance.
    state: ?ImageState = null,

    /// The reason for the state change.
    state_reason: ?StateReason = null,

    /// Any tags assigned to the image.
    tags: ?[]const Tag = null,

    /// If the image is configured for NitroTPM support, the value is `v2.0`. For
    /// more
    /// information, see
    /// [NitroTPM](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitrotpm.html) in the *Amazon EC2 User Guide*.
    tpm_support: ?TpmSupportValues = null,

    /// The operation of the Amazon EC2 instance and the billing code that is
    /// associated with the AMI.
    /// `usageOperation` corresponds to the
    /// [lineitem/Operation](https://docs.aws.amazon.com/cur/latest/userguide/Lineitem-columns.html#Lineitem-details-O-Operation) column on your Amazon Web Services Cost and Usage Report and in the [Amazon Web Services Price
    /// List
    /// API](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/price-changes.html). You can view these fields on the **Instances** or **AMIs** pages in the Amazon EC2 console,
    /// or in the responses that are returned by the
    /// [DescribeImages](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImages.html) command in
    /// the Amazon EC2 API, or the
    /// [describe-images](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html) command in the
    /// CLI.
    usage_operation: ?[]const u8 = null,

    /// The type of virtualization of the AMI.
    virtualization_type: ?VirtualizationType = null,
};
