/// Amazon CloudFront supports gRPC, an open-source remote procedure call (RPC)
/// framework built on HTTP/2. gRPC offers bi-directional streaming and binary
/// protocol that buffers payloads, making it suitable for applications that
/// require low latency communications.
///
/// To enable your distribution to handle gRPC requests, you must include HTTP/2
/// as one of the supported `HTTP` versions and allow `HTTP` methods, including
/// `POST`.
///
/// For more information, see [Using gRPC with CloudFront
/// distributions](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-using-grpc.html) in the *Amazon CloudFront Developer Guide*.
pub const GrpcConfig = struct {
    /// Enables your CloudFront distribution to receive gRPC requests and to proxy
    /// them directly to your origins.
    enabled: bool,
};
