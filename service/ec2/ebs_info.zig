const AttachmentLimitType = @import("attachment_limit_type.zig").AttachmentLimitType;
const EbsCardInfo = @import("ebs_card_info.zig").EbsCardInfo;
const EbsOptimizedInfo = @import("ebs_optimized_info.zig").EbsOptimizedInfo;
const EbsOptimizedSupport = @import("ebs_optimized_support.zig").EbsOptimizedSupport;
const EbsEncryptionSupport = @import("ebs_encryption_support.zig").EbsEncryptionSupport;
const EbsNvmeSupport = @import("ebs_nvme_support.zig").EbsNvmeSupport;

/// Describes the Amazon EBS features supported by the instance type.
pub const EbsInfo = struct {
    /// Indicates whether the instance type features a shared or dedicated Amazon
    /// EBS
    /// volume attachment limit. For more information, see [Amazon EBS volume limits
    /// for
    /// Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/volume_limits.html) in the *Amazon EC2 User Guide*.
    attachment_limit_type: ?AttachmentLimitType,

    /// Describes the EBS cards available for the instance type.
    ebs_cards: ?[]const EbsCardInfo,

    /// Describes the optimized EBS performance for the instance type.
    ebs_optimized_info: ?EbsOptimizedInfo,

    /// Indicates whether the instance type is Amazon EBS-optimized. For more
    /// information, see [Amazon EBS-optimized
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSOptimized.html) in *Amazon EC2 User Guide*.
    ebs_optimized_support: ?EbsOptimizedSupport,

    /// Indicates whether Amazon EBS encryption is supported.
    encryption_support: ?EbsEncryptionSupport,

    /// Indicates the maximum number of Amazon EBS volumes that can be attached to
    /// the instance type. For more information, see [Amazon EBS volume limits for
    /// Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/volume_limits.html) in the *Amazon EC2 User Guide*.
    maximum_ebs_attachments: ?i32,

    /// Indicates the number of EBS cards supported by the instance type.
    maximum_ebs_cards: ?i32,

    /// Indicates whether non-volatile memory express (NVMe) is supported.
    nvme_support: ?EbsNvmeSupport,
};
