const CreationDateConditionRequest = @import("creation_date_condition_request.zig").CreationDateConditionRequest;
const DeprecationTimeConditionRequest = @import("deprecation_time_condition_request.zig").DeprecationTimeConditionRequest;

/// The criteria that are evaluated to determine which AMIs are discoverable and
/// usable in
/// your account for the specified Amazon Web Services Region.
///
/// The `ImageCriteria` can include up to:
///
/// * 10 `ImageCriterion`
///
/// Each `ImageCriterion` can include up to:
///
/// * 200 values for `ImageProviders`
///
/// * 50 values for `ImageNames`
///
/// * 50 values for `MarketplaceProductCodes`
///
/// For more information, see [How Allowed AMIs
/// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html#how-allowed-amis-works) in the *Amazon EC2 User Guide*.
pub const ImageCriterionRequest = struct {
    /// The maximum age for allowed images.
    creation_date_condition: ?CreationDateConditionRequest = null,

    /// The maximum period since deprecation for allowed images.
    deprecation_time_condition: ?DeprecationTimeConditionRequest = null,

    /// The names of allowed images. Names can include wildcards (`?` and
    /// `*`).
    ///
    /// Length: 1–128 characters. With `?`, the minimum is 3 characters.
    ///
    /// Valid characters:
    ///
    /// * Letters: `A–Z, a–z`
    ///
    /// * Numbers: `0–9`
    ///
    /// * Special characters: `( ) [ ] . / - ' @ _ * ?`
    ///
    /// * Spaces
    ///
    /// Maximum: 50 values
    image_names: ?[]const []const u8 = null,

    /// The image providers whose images are allowed.
    ///
    /// Possible values:
    ///
    /// * `amazon`: Allow AMIs created by Amazon or verified providers.
    ///
    /// * `aws-marketplace`: Allow AMIs created by verified providers in the Amazon
    ///   Web Services
    /// Marketplace.
    ///
    /// * `aws-backup-vault`: Allow AMIs created by Amazon Web Services Backup.
    ///
    /// * 12-digit account ID: Allow AMIs created by the specified accounts. One or
    ///   more account IDs can be
    /// specified.
    ///
    /// * `none`: Allow AMIs created by your own account only. When `none` is
    /// specified, no other values can be specified.
    ///
    /// Maximum: 200 values
    image_providers: ?[]const []const u8 = null,

    /// The Amazon Web Services Marketplace product codes for allowed images.
    ///
    /// Length: 1-25 characters
    ///
    /// Valid characters: Letters (`A–Z, a–z`) and numbers (`0–9`)
    ///
    /// Maximum: 50 values
    marketplace_product_codes: ?[]const []const u8 = null,
};
