/// A data type that represents an Outpost.
///
/// For more information about RDS on Outposts, see [Amazon RDS on Amazon Web
/// Services
/// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide.*
pub const Outpost = struct {
    /// The Amazon Resource Name (ARN) of the Outpost.
    arn: ?[]const u8 = null,
};
