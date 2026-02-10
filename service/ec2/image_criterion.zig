const CreationDateCondition = @import("creation_date_condition.zig").CreationDateCondition;
const DeprecationTimeCondition = @import("deprecation_time_condition.zig").DeprecationTimeCondition;

/// The criteria that are evaluated to determine which AMIs are discoverable and
/// usable in
/// your account for the specified Amazon Web Services Region.
///
/// For more information, see [How Allowed AMIs
/// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html#how-allowed-amis-works) in the *Amazon EC2 User Guide*.
pub const ImageCriterion = struct {
    /// The maximum age for allowed images.
    creation_date_condition: ?CreationDateCondition,

    /// The maximum period since deprecation for allowed images.
    deprecation_time_condition: ?DeprecationTimeCondition,

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
    image_names: ?[]const []const u8,

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
    /// * 12-digit account ID: Allow AMIs created by this account. One or more
    ///   account IDs can be
    /// specified.
    ///
    /// * `none`: Allow AMIs created by your own account only.
    ///
    /// Maximum: 200 values
    image_providers: ?[]const []const u8,

    /// The Amazon Web Services Marketplace product codes for allowed images.
    ///
    /// Length: 1-25 characters
    ///
    /// Valid characters: Letters (`A–Z, a–z`) and numbers (`0–9`)
    ///
    /// Maximum: 50 values
    marketplace_product_codes: ?[]const []const u8,
};
