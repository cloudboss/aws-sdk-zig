/// Sets whether or not your output will go to a user created bucket. Used to
/// set the name
/// of the bucket, and the prefix on the output file.
///
/// `OutputConfig` is an optional parameter which lets you adjust where your
/// output will be placed. By default, Amazon Textract will store the results
/// internally and can
/// only be accessed by the Get API operations. With `OutputConfig` enabled, you
/// can
/// set the name of the bucket the output will be sent to the file prefix of the
/// results where
/// you can download your results. Additionally, you can set the `KMSKeyID`
/// parameter to a customer master key (CMK) to encrypt your output. Without
/// this parameter set
/// Amazon Textract will encrypt server-side using the AWS managed CMK for
/// Amazon S3.
///
/// Decryption of Customer Content is necessary for processing of the documents
/// by Amazon Textract. If your account
/// is opted out under an AI services opt out policy then all unencrypted
/// Customer Content is immediately and permanently deleted after
/// the Customer Content has been processed by the service. No copy of of the
/// output is retained by Amazon Textract. For information about how to opt out,
/// see [ Managing AI services opt-out policy.
/// ](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out.html)
///
/// For more information on data privacy,
/// see the [Data Privacy
/// FAQ](https://aws.amazon.com/compliance/data-privacy-faq/).
pub const OutputConfig = struct {
    /// The name of the bucket your output will go to.
    s3_bucket: []const u8,

    /// The prefix of the object key that the output will be saved to. When not
    /// enabled, the
    /// prefix will be “textract_output".
    s3_prefix: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_prefix = "S3Prefix",
    };
};
