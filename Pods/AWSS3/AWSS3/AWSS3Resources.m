/*
 Copyright 2010-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at
 
 http://aws.amazon.com/apache2.0
 
 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */

#import "AWSS3Resources.h"
#import "AWSLogging.h"

@interface AWSS3Resources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSS3Resources

+ (instancetype)sharedInstance {
    static AWSS3Resources *_sharedResources = nil;
    static dispatch_once_t once_token;
    
    dispatch_once(&once_token, ^{
        _sharedResources = [AWSS3Resources new];
    });
    
    return _sharedResources;
}
- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
  return @" \
  { \
    \"metadata\":{ \
      \"apiVersion\":\"2006-03-01\", \
      \"checksumFormat\":\"md5\", \
      \"endpointPrefix\":\"s3\", \
      \"globalEndpoint\":\"s3.amazonaws.com\", \
      \"serviceAbbreviation\":\"Amazon S3\", \
      \"serviceFullName\":\"Amazon Simple Storage Service\", \
      \"signatureVersion\":\"s3\", \
      \"timestampFormat\":\"rfc822\", \
      \"protocol\":\"rest-xml\" \
    }, \
    \"operations\":{ \
      \"AbortMultipartUpload\":{ \
        \"name\":\"AbortMultipartUpload\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"AbortMultipartUploadRequest\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchUpload\", \
            \"exception\":true, \
            \"documentation\":\"The specified multipart upload does not exist.\" \
          } \
        ], \
        \"documentation\":\"<p>Aborts a multipart upload.</p> <p>To verify that all parts have been removed, so you don't get charged for the part storage, you should call the List Parts operation and ensure the parts list is empty.</p>\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadAbort.html\" \
      }, \
      \"CompleteMultipartUpload\":{ \
        \"name\":\"CompleteMultipartUpload\", \
        \"http\":{ \
          \"method\":\"POST\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"CompleteMultipartUploadRequest\"}, \
        \"output\":{\"shape\":\"CompleteMultipartUploadOutput\"}, \
        \"documentation\":\"Completes a multipart upload by assembling previously uploaded parts.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadComplete.html\" \
      }, \
      \"CopyObject\":{ \
        \"name\":\"CopyObject\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"CopyObjectRequest\"}, \
        \"output\":{\"shape\":\"CopyObjectOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"ObjectNotInActiveTierError\", \
            \"exception\":true, \
            \"documentation\":\"The source object of the COPY operation is not in the active tier and is only stored in Amazon Glacier.\" \
          } \
        ], \
        \"documentation\":\"Creates a copy of an object that is already stored in Amazon S3.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectCOPY.html\", \
        \"alias\":\"PutObjectCopy\" \
      }, \
      \"CreateBucket\":{ \
        \"name\":\"CreateBucket\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}\" \
        }, \
        \"input\":{\"shape\":\"CreateBucketRequest\"}, \
        \"output\":{\"shape\":\"CreateBucketOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"BucketAlreadyExists\", \
            \"exception\":true, \
            \"documentation\":\"The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.\" \
          } \
        ], \
        \"documentation\":\"Creates a new bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUT.html\", \
        \"alias\":\"PutBucket\" \
      }, \
      \"CreateMultipartUpload\":{ \
        \"name\":\"CreateMultipartUpload\", \
        \"http\":{ \
          \"method\":\"POST\", \
          \"requestUri\":\"/{Bucket}/{Key+}?uploads\" \
        }, \
        \"input\":{\"shape\":\"CreateMultipartUploadRequest\"}, \
        \"output\":{\"shape\":\"CreateMultipartUploadOutput\"}, \
        \"documentation\":\"<p>Initiates a multipart upload and returns an upload ID.</p> <p><b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p>\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadInitiate.html\", \
        \"alias\":\"InitiateMultipartUpload\" \
      }, \
      \"DeleteBucket\":{ \
        \"name\":\"DeleteBucket\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketRequest\"}, \
        \"documentation\":\"Deletes the bucket. All objects (including all object versions and Delete Markers) in the bucket must be deleted before the bucket itself can be deleted.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETE.html\" \
      }, \
      \"DeleteBucketCors\":{ \
        \"name\":\"DeleteBucketCors\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}?cors\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketCorsRequest\"}, \
        \"documentation\":\"Deletes the cors configuration information set for the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEcors.html\" \
      }, \
      \"DeleteBucketLifecycle\":{ \
        \"name\":\"DeleteBucketLifecycle\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}?lifecycle\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketLifecycleRequest\"}, \
        \"documentation\":\"Deletes the lifecycle configuration from the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETElifecycle.html\" \
      }, \
      \"DeleteBucketPolicy\":{ \
        \"name\":\"DeleteBucketPolicy\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}?policy\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketPolicyRequest\"}, \
        \"documentation\":\"Deletes the policy from the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEpolicy.html\" \
      }, \
      \"DeleteBucketTagging\":{ \
        \"name\":\"DeleteBucketTagging\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}?tagging\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketTaggingRequest\"}, \
        \"documentation\":\"Deletes the tags from the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEtagging.html\" \
      }, \
      \"DeleteBucketWebsite\":{ \
        \"name\":\"DeleteBucketWebsite\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}?website\" \
        }, \
        \"input\":{\"shape\":\"DeleteBucketWebsiteRequest\"}, \
        \"documentation\":\"This operation removes the website configuration from the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketDELETEwebsite.html\" \
      }, \
      \"DeleteObject\":{ \
        \"name\":\"DeleteObject\", \
        \"http\":{ \
          \"method\":\"DELETE\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"DeleteObjectRequest\"}, \
        \"output\":{\"shape\":\"DeleteObjectOutput\"}, \
        \"documentation\":\"Removes the null version (if there is one) of an object and inserts a delete marker, which becomes the latest version of the object. If there isn't a null version, Amazon S3 does not remove any objects.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectDELETE.html\" \
      }, \
      \"DeleteObjects\":{ \
        \"name\":\"DeleteObjects\", \
        \"http\":{ \
          \"method\":\"POST\", \
          \"requestUri\":\"/{Bucket}?delete\" \
        }, \
        \"input\":{\"shape\":\"DeleteObjectsRequest\"}, \
        \"output\":{\"shape\":\"DeleteObjectsOutput\"}, \
        \"documentation\":\"This operation enables you to delete multiple objects from a bucket using a single HTTP request. You may specify up to 1000 keys.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/multiobjectdeleteapi.html\", \
        \"alias\":\"DeleteMultipleObjects\" \
      }, \
      \"GetBucketAcl\":{ \
        \"name\":\"GetBucketAcl\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?acl\" \
        }, \
        \"input\":{\"shape\":\"GetBucketAclRequest\"}, \
        \"output\":{\"shape\":\"GetBucketAclOutput\"}, \
        \"documentation\":\"Gets the access control policy for the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETacl.html\" \
      }, \
      \"GetBucketCors\":{ \
        \"name\":\"GetBucketCors\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?cors\" \
        }, \
        \"input\":{\"shape\":\"GetBucketCorsRequest\"}, \
        \"output\":{\"shape\":\"GetBucketCorsOutput\"}, \
        \"documentation\":\"Returns the cors configuration for the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETcors.html\" \
      }, \
      \"GetBucketLifecycle\":{ \
        \"name\":\"GetBucketLifecycle\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?lifecycle\" \
        }, \
        \"input\":{\"shape\":\"GetBucketLifecycleRequest\"}, \
        \"output\":{\"shape\":\"GetBucketLifecycleOutput\"}, \
        \"documentation\":\"Returns the lifecycle configuration information set on the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlifecycle.html\" \
      }, \
      \"GetBucketLocation\":{ \
        \"name\":\"GetBucketLocation\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?location\" \
        }, \
        \"input\":{\"shape\":\"GetBucketLocationRequest\"}, \
        \"output\":{\"shape\":\"GetBucketLocationOutput\"}, \
        \"documentation\":\"Returns the region the bucket resides in.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlocation.html\" \
      }, \
      \"GetBucketLogging\":{ \
        \"name\":\"GetBucketLogging\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?logging\" \
        }, \
        \"input\":{\"shape\":\"GetBucketLoggingRequest\"}, \
        \"output\":{\"shape\":\"GetBucketLoggingOutput\"}, \
        \"documentation\":\"Returns the logging status of a bucket and the permissions users have to view and modify that status. To use GET, you must be the bucket owner.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETlogging.html\" \
      }, \
      \"GetBucketNotification\":{ \
        \"name\":\"GetBucketNotification\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?notification\" \
        }, \
        \"input\":{\"shape\":\"GetBucketNotificationRequest\"}, \
        \"output\":{\"shape\":\"GetBucketNotificationOutput\"}, \
        \"documentation\":\"Return the notification configuration of a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETnotification.html\" \
      }, \
      \"GetBucketPolicy\":{ \
        \"name\":\"GetBucketPolicy\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?policy\" \
        }, \
        \"input\":{\"shape\":\"GetBucketPolicyRequest\"}, \
        \"output\":{\"shape\":\"GetBucketPolicyOutput\"}, \
        \"documentation\":\"Returns the policy of a specified bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETpolicy.html\" \
      }, \
      \"GetBucketRequestPayment\":{ \
        \"name\":\"GetBucketRequestPayment\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?requestPayment\" \
        }, \
        \"input\":{\"shape\":\"GetBucketRequestPaymentRequest\"}, \
        \"output\":{\"shape\":\"GetBucketRequestPaymentOutput\"}, \
        \"documentation\":\"Returns the request payment configuration of a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTrequestPaymentGET.html\" \
      }, \
      \"GetBucketTagging\":{ \
        \"name\":\"GetBucketTagging\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?tagging\" \
        }, \
        \"input\":{\"shape\":\"GetBucketTaggingRequest\"}, \
        \"output\":{\"shape\":\"GetBucketTaggingOutput\"}, \
        \"documentation\":\"Returns the tag set associated with the bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETtagging.html\" \
      }, \
      \"GetBucketVersioning\":{ \
        \"name\":\"GetBucketVersioning\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?versioning\" \
        }, \
        \"input\":{\"shape\":\"GetBucketVersioningRequest\"}, \
        \"output\":{\"shape\":\"GetBucketVersioningOutput\"}, \
        \"documentation\":\"Returns the versioning state of a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETversioningStatus.html\" \
      }, \
      \"GetBucketWebsite\":{ \
        \"name\":\"GetBucketWebsite\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?website\" \
        }, \
        \"input\":{\"shape\":\"GetBucketWebsiteRequest\"}, \
        \"output\":{\"shape\":\"GetBucketWebsiteOutput\"}, \
        \"documentation\":\"Returns the website configuration for a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETwebsite.html\" \
      }, \
      \"GetObject\":{ \
        \"name\":\"GetObject\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"GetObjectRequest\"}, \
        \"output\":{\"shape\":\"GetObjectOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchKey\", \
            \"exception\":true, \
            \"documentation\":\"The specified key does not exist.\" \
          } \
        ], \
        \"documentation\":\"Retrieves objects from Amazon S3.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGET.html\" \
      }, \
      \"GetObjectAcl\":{ \
        \"name\":\"GetObjectAcl\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}/{Key+}?acl\" \
        }, \
        \"input\":{\"shape\":\"GetObjectAclRequest\"}, \
        \"output\":{\"shape\":\"GetObjectAclOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchKey\", \
            \"exception\":true, \
            \"documentation\":\"The specified key does not exist.\" \
          } \
        ], \
        \"documentation\":\"Returns the access control list (ACL) of an object.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGETacl.html\" \
      }, \
      \"GetObjectTorrent\":{ \
        \"name\":\"GetObjectTorrent\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}/{Key+}?torrent\" \
        }, \
        \"input\":{\"shape\":\"GetObjectTorrentRequest\"}, \
        \"output\":{\"shape\":\"GetObjectTorrentOutput\"}, \
        \"documentation\":\"Return torrent files from a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectGETtorrent.html\" \
      }, \
      \"HeadBucket\":{ \
        \"name\":\"HeadBucket\", \
        \"http\":{ \
          \"method\":\"HEAD\", \
          \"requestUri\":\"/{Bucket}\" \
        }, \
        \"input\":{\"shape\":\"HeadBucketRequest\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchBucket\", \
            \"exception\":true, \
            \"documentation\":\"The specified bucket does not exist.\" \
          } \
        ], \
        \"documentation\":\"This operation is useful to determine if a bucket exists and you have permission to access it.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketHEAD.html\" \
      }, \
      \"HeadObject\":{ \
        \"name\":\"HeadObject\", \
        \"http\":{ \
          \"method\":\"HEAD\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"HeadObjectRequest\"}, \
        \"output\":{\"shape\":\"HeadObjectOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchKey\", \
            \"exception\":true, \
            \"documentation\":\"The specified key does not exist.\" \
          } \
        ], \
        \"documentation\":\"The HEAD operation retrieves metadata from an object without returning the object itself. This operation is useful if you're only interested in an object's metadata. To use HEAD, you must have READ access to the object.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectHEAD.html\" \
      }, \
      \"ListBuckets\":{ \
        \"name\":\"ListBuckets\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/\" \
        }, \
        \"output\":{\"shape\":\"ListBucketsOutput\"}, \
        \"documentation\":\"Returns a list of all buckets owned by the authenticated sender of the request.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTServiceGET.html\", \
        \"alias\":\"GetService\" \
      }, \
      \"ListMultipartUploads\":{ \
        \"name\":\"ListMultipartUploads\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?uploads\" \
        }, \
        \"input\":{\"shape\":\"ListMultipartUploadsRequest\"}, \
        \"output\":{\"shape\":\"ListMultipartUploadsOutput\"}, \
        \"documentation\":\"This operation lists in-progress multipart uploads.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadListMPUpload.html\" \
      }, \
      \"ListObjectVersions\":{ \
        \"name\":\"ListObjectVersions\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}?versions\" \
        }, \
        \"input\":{\"shape\":\"ListObjectVersionsRequest\"}, \
        \"output\":{\"shape\":\"ListObjectVersionsOutput\"}, \
        \"documentation\":\"Returns metadata about all of the versions of objects in a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGETVersion.html\", \
        \"alias\":\"GetBucketObjectVersions\" \
      }, \
      \"ListObjects\":{ \
        \"name\":\"ListObjects\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}\" \
        }, \
        \"input\":{\"shape\":\"ListObjectsRequest\"}, \
        \"output\":{\"shape\":\"ListObjectsOutput\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchBucket\", \
            \"exception\":true, \
            \"documentation\":\"The specified bucket does not exist.\" \
          } \
        ], \
        \"documentation\":\"Returns some or all (up to 1000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketGET.html\", \
        \"alias\":\"GetBucket\" \
      }, \
      \"ListParts\":{ \
        \"name\":\"ListParts\", \
        \"http\":{ \
          \"method\":\"GET\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"ListPartsRequest\"}, \
        \"output\":{\"shape\":\"ListPartsOutput\"}, \
        \"documentation\":\"Lists the parts that have been uploaded for a specific multipart upload.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadListParts.html\" \
      }, \
      \"PutBucketAcl\":{ \
        \"name\":\"PutBucketAcl\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?acl\" \
        }, \
        \"input\":{\"shape\":\"PutBucketAclRequest\"}, \
        \"documentation\":\"Sets the permissions on a bucket using access control lists (ACL).\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTacl.html\" \
      }, \
      \"PutBucketCors\":{ \
        \"name\":\"PutBucketCors\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?cors\" \
        }, \
        \"input\":{\"shape\":\"PutBucketCorsRequest\"}, \
        \"documentation\":\"Sets the cors configuration for a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTcors.html\" \
      }, \
      \"PutBucketLifecycle\":{ \
        \"name\":\"PutBucketLifecycle\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?lifecycle\" \
        }, \
        \"input\":{\"shape\":\"PutBucketLifecycleRequest\"}, \
        \"documentation\":\"Sets lifecycle configuration for your bucket. If a lifecycle configuration exists, it replaces it.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html\" \
      }, \
      \"PutBucketLogging\":{ \
        \"name\":\"PutBucketLogging\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?logging\" \
        }, \
        \"input\":{\"shape\":\"PutBucketLoggingRequest\"}, \
        \"documentation\":\"Set the logging parameters for a bucket and to specify permissions for who can view and modify the logging parameters. To set the logging status of a bucket, you must be the bucket owner.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTlogging.html\" \
      }, \
      \"PutBucketNotification\":{ \
        \"name\":\"PutBucketNotification\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?notification\" \
        }, \
        \"input\":{\"shape\":\"PutBucketNotificationRequest\"}, \
        \"documentation\":\"Enables notifications of specified events for a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTnotification.html\" \
      }, \
      \"PutBucketPolicy\":{ \
        \"name\":\"PutBucketPolicy\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?policy\" \
        }, \
        \"input\":{\"shape\":\"PutBucketPolicyRequest\"}, \
        \"documentation\":\"Replaces a policy on a bucket. If the bucket already has a policy, the one in this request completely replaces it.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTpolicy.html\" \
      }, \
      \"PutBucketRequestPayment\":{ \
        \"name\":\"PutBucketRequestPayment\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?requestPayment\" \
        }, \
        \"input\":{\"shape\":\"PutBucketRequestPaymentRequest\"}, \
        \"documentation\":\"Sets the request payment configuration for a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTrequestPaymentPUT.html\" \
      }, \
      \"PutBucketTagging\":{ \
        \"name\":\"PutBucketTagging\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?tagging\" \
        }, \
        \"input\":{\"shape\":\"PutBucketTaggingRequest\"}, \
        \"documentation\":\"Sets the tags for a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTtagging.html\" \
      }, \
      \"PutBucketVersioning\":{ \
        \"name\":\"PutBucketVersioning\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?versioning\" \
        }, \
        \"input\":{\"shape\":\"PutBucketVersioningRequest\"}, \
        \"documentation\":\"Sets the versioning state of an existing bucket. To set the versioning state, you must be the bucket owner.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html\" \
      }, \
      \"PutBucketWebsite\":{ \
        \"name\":\"PutBucketWebsite\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}?website\" \
        }, \
        \"input\":{\"shape\":\"PutBucketWebsiteRequest\"}, \
        \"documentation\":\"Set the website configuration for a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTBucketPUTwebsite.html\" \
      }, \
      \"PutObject\":{ \
        \"name\":\"PutObject\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"PutObjectRequest\"}, \
        \"output\":{\"shape\":\"PutObjectOutput\"}, \
        \"documentation\":\"Adds an object to a bucket.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectPUT.html\" \
      }, \
      \"PutObjectAcl\":{ \
        \"name\":\"PutObjectAcl\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}/{Key+}?acl\" \
        }, \
        \"input\":{\"shape\":\"PutObjectAclRequest\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"NoSuchKey\", \
            \"exception\":true, \
            \"documentation\":\"The specified key does not exist.\" \
          } \
        ], \
        \"documentation\":\"uses the acl subresource to set the access control list (ACL) permissions for an object that already exists in a bucket\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectPUTacl.html\" \
      }, \
      \"RestoreObject\":{ \
        \"name\":\"RestoreObject\", \
        \"http\":{ \
          \"method\":\"POST\", \
          \"requestUri\":\"/{Bucket}/{Key+}?restore\" \
        }, \
        \"input\":{\"shape\":\"RestoreObjectRequest\"}, \
        \"errors\":[ \
          { \
            \"shape\":\"ObjectAlreadyInActiveTierError\", \
            \"exception\":true, \
            \"documentation\":\"This operation is not allowed against this storage tier\" \
          } \
        ], \
        \"documentation\":\"Restores an archived copy of an object back into Amazon S3\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectRestore.html\", \
        \"alias\":\"PostObjectRestore\" \
      }, \
      \"UploadPart\":{ \
        \"name\":\"UploadPart\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"UploadPartRequest\"}, \
        \"output\":{\"shape\":\"UploadPartOutput\"}, \
        \"documentation\":\"<p>Uploads a part in a multipart upload.</p> <p><b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p>\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadUploadPart.html\" \
      }, \
      \"UploadPartCopy\":{ \
        \"name\":\"UploadPartCopy\", \
        \"http\":{ \
          \"method\":\"PUT\", \
          \"requestUri\":\"/{Bucket}/{Key+}\" \
        }, \
        \"input\":{\"shape\":\"UploadPartCopyRequest\"}, \
        \"output\":{\"shape\":\"UploadPartCopyOutput\"}, \
        \"documentation\":\"Uploads a part by copying data from an existing object as data source.\", \
        \"documentationUrl\":\"http://docs.amazonwebservices.com/AmazonS3/latest/API/mpUploadUploadPartCopy.html\" \
      } \
    }, \
    \"shapes\":{ \
      \"AbortMultipartUploadRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\", \
          \"UploadId\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"uploadId\" \
          } \
        } \
      }, \
      \"AcceptRanges\":{\"type\":\"string\"}, \
      \"AccessControlPolicy\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Grants\":{ \
            \"shape\":\"Grants\", \
            \"documentation\":\"A list of grants.\", \
            \"locationName\":\"AccessControlList\" \
          }, \
          \"Owner\":{\"shape\":\"Owner\"} \
        } \
      }, \
      \"AllowedHeader\":{\"type\":\"string\"}, \
      \"AllowedHeaders\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"AllowedHeader\"}, \
        \"flattened\":true \
      }, \
      \"AllowedMethod\":{\"type\":\"string\"}, \
      \"AllowedMethods\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"AllowedMethod\"}, \
        \"flattened\":true \
      }, \
      \"AllowedOrigin\":{\"type\":\"string\"}, \
      \"AllowedOrigins\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"AllowedOrigin\"}, \
        \"flattened\":true \
      }, \
      \"Body\":{\"type\":\"blob\"}, \
      \"Bucket\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Name\":{ \
            \"shape\":\"BucketName\", \
            \"documentation\":\"The name of the bucket.\" \
          }, \
          \"CreationDate\":{ \
            \"shape\":\"CreationDate\", \
            \"documentation\":\"Date the bucket was created.\" \
          } \
        } \
      }, \
      \"BucketAlreadyExists\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.\" \
      }, \
      \"BucketCannedACL\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"private\", \
          \"public-read\", \
          \"public-read-write\", \
          \"authenticated-read\" \
        ] \
      }, \
      \"BucketLocationConstraint\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"EU\", \
          \"eu-west-1\", \
          \"us-west-1\", \
          \"us-west-2\", \
          \"ap-southeast-1\", \
          \"ap-southeast-2\", \
          \"ap-northeast-1\", \
          \"sa-east-1\", \
          \"\", \
          \"cn-north-1\", \
          \"eu-central-1\", \
          \"us-gov-west-1\" \
        ] \
      }, \
      \"BucketLoggingStatus\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"LoggingEnabled\":{\"shape\":\"LoggingEnabled\"} \
        } \
      }, \
      \"BucketLogsPermission\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"FULL_CONTROL\", \
          \"READ\", \
          \"WRITE\" \
        ] \
      }, \
      \"BucketName\":{\"type\":\"string\"}, \
      \"BucketVersioningStatus\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"Enabled\", \
          \"Suspended\" \
        ] \
      }, \
      \"Buckets\":{ \
        \"type\":\"list\", \
        \"member\":{ \
          \"shape\":\"Bucket\", \
          \"locationName\":\"Bucket\" \
        } \
      }, \
      \"CORSConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"CORSRules\":{ \
            \"shape\":\"CORSRules\", \
            \"locationName\":\"CORSRule\" \
          } \
        } \
      }, \
      \"CORSRule\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"AllowedHeaders\":{ \
            \"shape\":\"AllowedHeaders\", \
            \"documentation\":\"Specifies which headers are allowed in a pre-flight OPTIONS request.\", \
            \"locationName\":\"AllowedHeader\" \
          }, \
          \"AllowedMethods\":{ \
            \"shape\":\"AllowedMethods\", \
            \"documentation\":\"Identifies HTTP methods that the domain/origin specified in the rule is allowed to execute.\", \
            \"locationName\":\"AllowedMethod\" \
          }, \
          \"AllowedOrigins\":{ \
            \"shape\":\"AllowedOrigins\", \
            \"documentation\":\"One or more origins you want customers to be able to access the bucket from.\", \
            \"locationName\":\"AllowedOrigin\" \
          }, \
          \"ExposeHeaders\":{ \
            \"shape\":\"ExposeHeaders\", \
            \"documentation\":\"One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).\", \
            \"locationName\":\"ExposeHeader\" \
          }, \
          \"MaxAgeSeconds\":{ \
            \"shape\":\"MaxAgeSeconds\", \
            \"documentation\":\"The time in seconds that your browser is to cache the preflight response for the specified resource.\" \
          } \
        } \
      }, \
      \"CORSRules\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"CORSRule\"}, \
        \"flattened\":true \
      }, \
      \"CacheControl\":{\"type\":\"string\"}, \
      \"CloudFunction\":{\"type\":\"string\"}, \
      \"CloudFunctionConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Id\":{\"shape\":\"NotificationId\"}, \
          \"Event\":{ \
            \"shape\":\"Event\", \
            \"deprecated\":true \
          }, \
          \"Events\":{ \
            \"shape\":\"Events\", \
            \"locationName\":\"Event\" \
          }, \
          \"CloudFunction\":{\"shape\":\"CloudFunction\"}, \
          \"InvocationRole\":{\"shape\":\"CloudFunctionInvocationRole\"} \
        } \
      }, \
      \"CloudFunctionInvocationRole\":{\"type\":\"string\"}, \
      \"Code\":{\"type\":\"string\"}, \
      \"CommonPrefix\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Prefix\":{\"shape\":\"Prefix\"} \
        } \
      }, \
      \"CommonPrefixList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"CommonPrefix\"}, \
        \"flattened\":true \
      }, \
      \"CompleteMultipartUploadOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Location\":{\"shape\":\"Location\"}, \
          \"Bucket\":{\"shape\":\"BucketName\"}, \
          \"Key\":{\"shape\":\"ObjectKey\"}, \
          \"Expiration\":{ \
            \"shape\":\"Expiration\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-expiration\", \
            \"documentation\":\"If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"documentation\":\"Entity tag of the object.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-version-id\", \
            \"documentation\":\"Version of the object.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        } \
      }, \
      \"CompleteMultipartUploadRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\", \
          \"UploadId\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"MultipartUpload\":{ \
            \"shape\":\"CompletedMultipartUpload\", \
            \"locationName\":\"CompleteMultipartUpload\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"} \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"uploadId\" \
          } \
        }, \
        \"payload\":\"MultipartUpload\" \
      }, \
      \"CompletedMultipartUpload\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Parts\":{ \
            \"shape\":\"CompletedPartList\", \
            \"locationName\":\"Part\" \
          } \
        } \
      }, \
      \"CompletedPart\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"documentation\":\"Entity tag returned when the part was uploaded.\" \
          }, \
          \"PartNumber\":{ \
            \"shape\":\"PartNumber\", \
            \"documentation\":\"Part number that identifies the part.\" \
          } \
        } \
      }, \
      \"CompletedPartList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"CompletedPart\"}, \
        \"flattened\":true \
      }, \
      \"Condition\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"HttpErrorCodeReturnedEquals\":{ \
            \"shape\":\"HttpErrorCodeReturnedEquals\", \
            \"documentation\":\"The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element Condition is specified and sibling KeyPrefixEquals is not specified. If both are specified, then both must be true for the redirect to be applied.\" \
          }, \
          \"KeyPrefixEquals\":{ \
            \"shape\":\"KeyPrefixEquals\", \
            \"documentation\":\"The object key name prefix when the redirect is applied. For example, to redirect requests for ExamplePage.html, the key prefix will be ExamplePage.html. To redirect request for all pages with the prefix docs/, the key prefix will be /docs, which identifies all objects in the docs/ folder. Required when the parent element Condition is specified and sibling HttpErrorCodeReturnedEquals is not specified. If both conditions are specified, both must be true for the redirect to be applied.\" \
          } \
        } \
      }, \
      \"ContentDisposition\":{\"type\":\"string\"}, \
      \"ContentEncoding\":{\"type\":\"string\"}, \
      \"ContentLanguage\":{\"type\":\"string\"}, \
      \"ContentLength\":{\"type\":\"integer\"}, \
      \"ContentMD5\":{\"type\":\"string\"}, \
      \"ContentType\":{\"type\":\"string\"}, \
      \"CopyObjectOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"CopyObjectResult\":{\"shape\":\"CopyObjectResult\"}, \
          \"Expiration\":{ \
            \"shape\":\"Expiration\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-expiration\", \
            \"documentation\":\"If the object expiration is configured, the response includes this header.\" \
          }, \
          \"CopySourceVersionId\":{ \
            \"shape\":\"CopySourceVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-version-id\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        }, \
        \"payload\":\"CopyObjectResult\" \
      }, \
      \"CopyObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"CopySource\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"ObjectCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the object.\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CacheControl\":{ \
            \"shape\":\"CacheControl\", \
            \"location\":\"header\", \
            \"locationName\":\"Cache-Control\", \
            \"documentation\":\"Specifies caching behavior along the request/reply chain.\" \
          }, \
          \"ContentDisposition\":{ \
            \"shape\":\"ContentDisposition\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Disposition\", \
            \"documentation\":\"Specifies presentational information for the object.\" \
          }, \
          \"ContentEncoding\":{ \
            \"shape\":\"ContentEncoding\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Encoding\", \
            \"documentation\":\"Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.\" \
          }, \
          \"ContentLanguage\":{ \
            \"shape\":\"ContentLanguage\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Language\", \
            \"documentation\":\"The language the content is in.\" \
          }, \
          \"ContentType\":{ \
            \"shape\":\"ContentType\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Type\", \
            \"documentation\":\"A standard MIME type describing the format of the object data.\" \
          }, \
          \"CopySource\":{ \
            \"shape\":\"CopySource\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source\", \
            \"documentation\":\"The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.\" \
          }, \
          \"CopySourceIfMatch\":{ \
            \"shape\":\"CopySourceIfMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-match\", \
            \"documentation\":\"Copies the object if its entity tag (ETag) matches the specified tag.\" \
          }, \
          \"CopySourceIfModifiedSince\":{ \
            \"shape\":\"CopySourceIfModifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-modified-since\", \
            \"documentation\":\"Copies the object if it has been modified since the specified time.\" \
          }, \
          \"CopySourceIfNoneMatch\":{ \
            \"shape\":\"CopySourceIfNoneMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-none-match\", \
            \"documentation\":\"Copies the object if its entity tag (ETag) is different than the specified ETag.\" \
          }, \
          \"CopySourceIfUnmodifiedSince\":{ \
            \"shape\":\"CopySourceIfUnmodifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-unmodified-since\", \
            \"documentation\":\"Copies the object if it hasn't been modified since the specified time.\" \
          }, \
          \"Expires\":{ \
            \"shape\":\"Expires\", \
            \"location\":\"header\", \
            \"locationName\":\"Expires\", \
            \"documentation\":\"The date and time at which the object is no longer cacheable.\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to read the object data and its metadata.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the object ACL.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable object.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"Metadata\":{ \
            \"shape\":\"Metadata\", \
            \"location\":\"headers\", \
            \"documentation\":\"A map of metadata to store with the object in S3.\", \
            \"locationName\":\"x-amz-meta-\" \
          }, \
          \"MetadataDirective\":{ \
            \"shape\":\"MetadataDirective\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-metadata-directive\", \
            \"documentation\":\"Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"StorageClass\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-storage-class\", \
            \"documentation\":\"The type of storage to use for the object. Defaults to 'STANDARD'.\" \
          }, \
          \"WebsiteRedirectLocation\":{ \
            \"shape\":\"WebsiteRedirectLocation\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-website-redirect-location\", \
            \"documentation\":\"If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\" \
          }, \
          \"CopySourceSSECustomerAlgorithm\":{ \
            \"shape\":\"CopySourceSSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use when decrypting the source object (e.g., AES256).\" \
          }, \
          \"CopySourceSSECustomerKey\":{ \
            \"shape\":\"CopySourceSSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.\" \
          }, \
          \"CopySourceSSECustomerKeyMD5\":{ \
            \"shape\":\"CopySourceSSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          } \
        } \
      }, \
      \"CopyObjectResult\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ETag\":{\"shape\":\"ETag\"}, \
          \"LastModified\":{\"shape\":\"LastModified\"} \
        } \
      }, \
      \"CopyPartResult\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"documentation\":\"Entity tag of the object.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"documentation\":\"Date and time at which the object was uploaded.\" \
          } \
        } \
      }, \
      \"CopySource\":{ \
        \"type\":\"string\", \
        \"pattern\":\"\\\\/.+\\\\/.+\" \
      }, \
      \"CopySourceIfMatch\":{\"type\":\"string\"}, \
      \"CopySourceIfModifiedSince\":{\"type\":\"timestamp\"}, \
      \"CopySourceIfNoneMatch\":{\"type\":\"string\"}, \
      \"CopySourceIfUnmodifiedSince\":{\"type\":\"timestamp\"}, \
      \"CopySourceRange\":{\"type\":\"string\"}, \
      \"CopySourceSSECustomerAlgorithm\":{\"type\":\"string\"}, \
      \"CopySourceSSECustomerKey\":{ \
        \"type\":\"string\", \
        \"sensitive\":true \
      }, \
      \"CopySourceSSECustomerKeyMD5\":{\"type\":\"string\"}, \
      \"CopySourceVersionId\":{\"type\":\"string\"}, \
      \"CreateBucketConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"LocationConstraint\":{ \
            \"shape\":\"BucketLocationConstraint\", \
            \"documentation\":\"Specifies the region where the bucket will be created.\" \
          } \
        } \
      }, \
      \"CreateBucketOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Location\":{ \
            \"shape\":\"Location\", \
            \"location\":\"header\", \
            \"locationName\":\"Location\" \
          } \
        } \
      }, \
      \"CreateBucketRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"BucketCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the bucket.\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CreateBucketConfiguration\":{ \
            \"shape\":\"CreateBucketConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"CreateBucketConfiguration\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to list the objects in the bucket.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the bucket ACL.\" \
          }, \
          \"GrantWrite\":{ \
            \"shape\":\"GrantWrite\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write\", \
            \"documentation\":\"Allows grantee to create, overwrite, and delete any object in the bucket.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable bucket.\" \
          } \
        }, \
        \"payload\":\"CreateBucketConfiguration\" \
      }, \
      \"CreateMultipartUploadOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"documentation\":\"Name of the bucket to which the multipart upload was initiated.\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"Object key for which the multipart upload was initiated.\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"documentation\":\"ID for the initiated multipart upload.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        } \
      }, \
      \"CreateMultipartUploadRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"ObjectCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the object.\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CacheControl\":{ \
            \"shape\":\"CacheControl\", \
            \"location\":\"header\", \
            \"locationName\":\"Cache-Control\", \
            \"documentation\":\"Specifies caching behavior along the request/reply chain.\" \
          }, \
          \"ContentDisposition\":{ \
            \"shape\":\"ContentDisposition\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Disposition\", \
            \"documentation\":\"Specifies presentational information for the object.\" \
          }, \
          \"ContentEncoding\":{ \
            \"shape\":\"ContentEncoding\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Encoding\", \
            \"documentation\":\"Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.\" \
          }, \
          \"ContentLanguage\":{ \
            \"shape\":\"ContentLanguage\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Language\", \
            \"documentation\":\"The language the content is in.\" \
          }, \
          \"ContentType\":{ \
            \"shape\":\"ContentType\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Type\", \
            \"documentation\":\"A standard MIME type describing the format of the object data.\" \
          }, \
          \"Expires\":{ \
            \"shape\":\"Expires\", \
            \"location\":\"header\", \
            \"locationName\":\"Expires\", \
            \"documentation\":\"The date and time at which the object is no longer cacheable.\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to read the object data and its metadata.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the object ACL.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable object.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"Metadata\":{ \
            \"shape\":\"Metadata\", \
            \"location\":\"headers\", \
            \"documentation\":\"A map of metadata to store with the object in S3.\", \
            \"locationName\":\"x-amz-meta-\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"StorageClass\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-storage-class\", \
            \"documentation\":\"The type of storage to use for the object. Defaults to 'STANDARD'.\" \
          }, \
          \"WebsiteRedirectLocation\":{ \
            \"shape\":\"WebsiteRedirectLocation\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-website-redirect-location\", \
            \"documentation\":\"If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\" \
          } \
        } \
      }, \
      \"CreationDate\":{\"type\":\"timestamp\"}, \
      \"Date\":{ \
        \"type\":\"timestamp\", \
        \"timestampFormat\":\"iso8601\" \
      }, \
      \"Days\":{\"type\":\"integer\"}, \
      \"Delete\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Objects\"], \
        \"members\":{ \
          \"Objects\":{ \
            \"shape\":\"ObjectIdentifierList\", \
            \"locationName\":\"Object\" \
          }, \
          \"Quiet\":{ \
            \"shape\":\"Quiet\", \
            \"documentation\":\"Element to enable quiet mode for the request. When you add this element, you must set its value to true.\" \
          } \
        } \
      }, \
      \"DeleteBucketCorsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteBucketLifecycleRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteBucketPolicyRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteBucketRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteBucketTaggingRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteBucketWebsiteRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"DeleteMarker\":{\"type\":\"boolean\"}, \
      \"DeleteMarkerEntry\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Owner\":{\"shape\":\"Owner\"}, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"The object key.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"documentation\":\"Version ID of an object.\" \
          }, \
          \"IsLatest\":{ \
            \"shape\":\"IsLatest\", \
            \"documentation\":\"Specifies whether the object is (true) or is not (false) the latest version of an object.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"documentation\":\"Date and time the object was last modified.\" \
          } \
        } \
      }, \
      \"DeleteMarkerVersionId\":{\"type\":\"string\"}, \
      \"DeleteMarkers\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"DeleteMarkerEntry\"}, \
        \"flattened\":true \
      }, \
      \"DeleteObjectOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"DeleteMarker\":{ \
            \"shape\":\"DeleteMarker\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-delete-marker\", \
            \"documentation\":\"Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-version-id\", \
            \"documentation\":\"Returns the version ID of the delete marker created as a result of the DELETE operation.\" \
          } \
        } \
      }, \
      \"DeleteObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"MFA\":{ \
            \"shape\":\"MFA\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-mfa\", \
            \"documentation\":\"The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"versionId\", \
            \"documentation\":\"VersionId used to reference a specific version of the object.\" \
          } \
        } \
      }, \
      \"DeleteObjectsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Deleted\":{\"shape\":\"DeletedObjects\"}, \
          \"Errors\":{ \
            \"shape\":\"Errors\", \
            \"locationName\":\"Error\" \
          } \
        } \
      }, \
      \"DeleteObjectsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Delete\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Delete\":{ \
            \"shape\":\"Delete\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"Delete\" \
          }, \
          \"MFA\":{ \
            \"shape\":\"MFA\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-mfa\", \
            \"documentation\":\"The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.\" \
          } \
        }, \
        \"payload\":\"Delete\" \
      }, \
      \"DeletedObject\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Key\":{\"shape\":\"ObjectKey\"}, \
          \"VersionId\":{\"shape\":\"ObjectVersionId\"}, \
          \"DeleteMarker\":{\"shape\":\"DeleteMarker\"}, \
          \"DeleteMarkerVersionId\":{\"shape\":\"DeleteMarkerVersionId\"} \
        } \
      }, \
      \"DeletedObjects\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"DeletedObject\"}, \
        \"flattened\":true \
      }, \
      \"Delimiter\":{\"type\":\"string\"}, \
      \"DisplayName\":{\"type\":\"string\"}, \
      \"ETag\":{\"type\":\"string\"}, \
      \"EmailAddress\":{\"type\":\"string\"}, \
      \"EncodingType\":{ \
        \"type\":\"string\", \
        \"enum\":[\"url\"], \
        \"documentation\":\"Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.\" \
      }, \
      \"Error\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Key\":{\"shape\":\"ObjectKey\"}, \
          \"VersionId\":{\"shape\":\"ObjectVersionId\"}, \
          \"Code\":{\"shape\":\"Code\"}, \
          \"Message\":{\"shape\":\"Message\"} \
        } \
      }, \
      \"ErrorDocument\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Key\"], \
        \"members\":{ \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"The object key name to use when a 4XX class error occurs.\" \
          } \
        } \
      }, \
      \"Errors\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"Error\"}, \
        \"flattened\":true \
      }, \
      \"Event\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"s3:ReducedRedundancyLostObject\", \
          \"s3:ObjectCreated:Put\", \
          \"s3:ObjectCreated:Post\", \
          \"s3:ObjectCreated:Copy\", \
          \"s3:ObjectCreated:CompleteMultipartUpload\" \
        ] \
      }, \
      \"Events\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"Event\"}, \
        \"flattened\":true \
      }, \
      \"Expiration\":{\"type\":\"string\"}, \
      \"ExpirationStatus\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"Enabled\", \
          \"Disabled\" \
        ] \
      }, \
      \"Expires\":{\"type\":\"timestamp\"}, \
      \"ExposeHeader\":{\"type\":\"string\"}, \
      \"ExposeHeaders\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"ExposeHeader\"}, \
        \"flattened\":true \
      }, \
      \"GetBucketAclOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Owner\":{\"shape\":\"Owner\"}, \
          \"Grants\":{ \
            \"shape\":\"Grants\", \
            \"documentation\":\"A list of grants.\", \
            \"locationName\":\"AccessControlList\" \
          } \
        } \
      }, \
      \"GetBucketAclRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketCorsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"CORSRules\":{ \
            \"shape\":\"CORSRules\", \
            \"locationName\":\"CORSRule\" \
          } \
        } \
      }, \
      \"GetBucketCorsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketLifecycleOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Rules\":{ \
            \"shape\":\"Rules\", \
            \"locationName\":\"Rule\" \
          } \
        } \
      }, \
      \"GetBucketLifecycleRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketLocationOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"LocationConstraint\":{\"shape\":\"BucketLocationConstraint\"} \
        } \
      }, \
      \"GetBucketLocationRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketLoggingOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"LoggingEnabled\":{\"shape\":\"LoggingEnabled\"} \
        } \
      }, \
      \"GetBucketLoggingRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketNotificationOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"TopicConfiguration\":{\"shape\":\"TopicConfiguration\"}, \
          \"QueueConfiguration\":{\"shape\":\"QueueConfiguration\"}, \
          \"CloudFunctionConfiguration\":{\"shape\":\"CloudFunctionConfiguration\"} \
        } \
      }, \
      \"GetBucketNotificationRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketPolicyOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Policy\":{ \
            \"shape\":\"Policy\", \
            \"documentation\":\"The bucket policy as a JSON document.\" \
          } \
        }, \
        \"payload\":\"Policy\" \
      }, \
      \"GetBucketPolicyRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketRequestPaymentOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Payer\":{ \
            \"shape\":\"Payer\", \
            \"documentation\":\"Specifies who pays for the download and request fees.\" \
          } \
        } \
      }, \
      \"GetBucketRequestPaymentRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketTaggingOutput\":{ \
        \"type\":\"structure\", \
        \"required\":[\"TagSet\"], \
        \"members\":{ \
          \"TagSet\":{\"shape\":\"TagSet\"} \
        } \
      }, \
      \"GetBucketTaggingRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketVersioningOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Status\":{ \
            \"shape\":\"BucketVersioningStatus\", \
            \"documentation\":\"The versioning state of the bucket.\" \
          }, \
          \"MFADelete\":{ \
            \"shape\":\"MFADeleteStatus\", \
            \"documentation\":\"Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.\", \
            \"locationName\":\"MfaDelete\" \
          } \
        } \
      }, \
      \"GetBucketVersioningRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetBucketWebsiteOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"RedirectAllRequestsTo\":{\"shape\":\"RedirectAllRequestsTo\"}, \
          \"IndexDocument\":{\"shape\":\"IndexDocument\"}, \
          \"ErrorDocument\":{\"shape\":\"ErrorDocument\"}, \
          \"RoutingRules\":{\"shape\":\"RoutingRules\"} \
        } \
      }, \
      \"GetBucketWebsiteRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"GetObjectAclOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Owner\":{\"shape\":\"Owner\"}, \
          \"Grants\":{ \
            \"shape\":\"Grants\", \
            \"documentation\":\"A list of grants.\", \
            \"locationName\":\"AccessControlList\" \
          } \
        } \
      }, \
      \"GetObjectAclRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"versionId\", \
            \"documentation\":\"VersionId used to reference a specific version of the object.\" \
          } \
        } \
      }, \
      \"GetObjectOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Body\":{ \
            \"shape\":\"Body\", \
            \"streaming\":true, \
            \"documentation\":\"Object data.\" \
          }, \
          \"DeleteMarker\":{ \
            \"shape\":\"DeleteMarker\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-delete-marker\", \
            \"documentation\":\"Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.\" \
          }, \
          \"AcceptRanges\":{ \
            \"shape\":\"AcceptRanges\", \
            \"location\":\"header\", \
            \"locationName\":\"accept-ranges\" \
          }, \
          \"Expiration\":{ \
            \"shape\":\"Expiration\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-expiration\", \
            \"documentation\":\"If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.\" \
          }, \
          \"Restore\":{ \
            \"shape\":\"Restore\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-restore\", \
            \"documentation\":\"Provides information about object restoration operation and expiration time of the restored object copy.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"location\":\"header\", \
            \"locationName\":\"Last-Modified\", \
            \"documentation\":\"Last modified date of the object\" \
          }, \
          \"ContentLength\":{ \
            \"shape\":\"ContentLength\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Length\", \
            \"documentation\":\"Size of the body in bytes.\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"location\":\"header\", \
            \"locationName\":\"ETag\", \
            \"documentation\":\"An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL\" \
          }, \
          \"MissingMeta\":{ \
            \"shape\":\"MissingMeta\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-missing-meta\", \
            \"documentation\":\"This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-version-id\", \
            \"documentation\":\"Version of the object.\" \
          }, \
          \"CacheControl\":{ \
            \"shape\":\"CacheControl\", \
            \"location\":\"header\", \
            \"locationName\":\"Cache-Control\", \
            \"documentation\":\"Specifies caching behavior along the request/reply chain.\" \
          }, \
          \"ContentDisposition\":{ \
            \"shape\":\"ContentDisposition\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Disposition\", \
            \"documentation\":\"Specifies presentational information for the object.\" \
          }, \
          \"ContentEncoding\":{ \
            \"shape\":\"ContentEncoding\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Encoding\", \
            \"documentation\":\"Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.\" \
          }, \
          \"ContentLanguage\":{ \
            \"shape\":\"ContentLanguage\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Language\", \
            \"documentation\":\"The language the content is in.\" \
          }, \
          \"ContentType\":{ \
            \"shape\":\"ContentType\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Type\", \
            \"documentation\":\"A standard MIME type describing the format of the object data.\" \
          }, \
          \"Expires\":{ \
            \"shape\":\"Expires\", \
            \"location\":\"header\", \
            \"locationName\":\"Expires\", \
            \"documentation\":\"The date and time at which the object is no longer cacheable.\" \
          }, \
          \"WebsiteRedirectLocation\":{ \
            \"shape\":\"WebsiteRedirectLocation\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-website-redirect-location\", \
            \"documentation\":\"If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"Metadata\":{ \
            \"shape\":\"Metadata\", \
            \"location\":\"headers\", \
            \"documentation\":\"A map of metadata to store with the object in S3.\", \
            \"locationName\":\"x-amz-meta-\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        }, \
        \"payload\":\"Body\" \
      }, \
      \"GetObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"IfMatch\":{ \
            \"shape\":\"IfMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Match\", \
            \"documentation\":\"Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).\" \
          }, \
          \"IfModifiedSince\":{ \
            \"shape\":\"IfModifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Modified-Since\", \
            \"documentation\":\"Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).\" \
          }, \
          \"IfNoneMatch\":{ \
            \"shape\":\"IfNoneMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"If-None-Match\", \
            \"documentation\":\"Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).\" \
          }, \
          \"IfUnmodifiedSince\":{ \
            \"shape\":\"IfUnmodifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Unmodified-Since\", \
            \"documentation\":\"Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"Range\":{ \
            \"shape\":\"Range\", \
            \"location\":\"header\", \
            \"locationName\":\"Range\", \
            \"documentation\":\"Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.\" \
          }, \
          \"ResponseCacheControl\":{ \
            \"shape\":\"ResponseCacheControl\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-cache-control\", \
            \"documentation\":\"Sets the Cache-Control header of the response.\" \
          }, \
          \"ResponseContentDisposition\":{ \
            \"shape\":\"ResponseContentDisposition\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-content-disposition\", \
            \"documentation\":\"Sets the Content-Disposition header of the response\" \
          }, \
          \"ResponseContentEncoding\":{ \
            \"shape\":\"ResponseContentEncoding\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-content-encoding\", \
            \"documentation\":\"Sets the Content-Encoding header of the response.\" \
          }, \
          \"ResponseContentLanguage\":{ \
            \"shape\":\"ResponseContentLanguage\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-content-language\", \
            \"documentation\":\"Sets the Content-Language header of the response.\" \
          }, \
          \"ResponseContentType\":{ \
            \"shape\":\"ResponseContentType\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-content-type\", \
            \"documentation\":\"Sets the Content-Type header of the response.\" \
          }, \
          \"ResponseExpires\":{ \
            \"shape\":\"ResponseExpires\", \
            \"location\":\"querystring\", \
            \"locationName\":\"response-expires\", \
            \"documentation\":\"Sets the Expires header of the response.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"versionId\", \
            \"documentation\":\"VersionId used to reference a specific version of the object.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          } \
        } \
      }, \
      \"GetObjectTorrentOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Body\":{ \
            \"shape\":\"Body\", \
            \"streaming\":true \
          } \
        }, \
        \"payload\":\"Body\" \
      }, \
      \"GetObjectTorrentRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          } \
        } \
      }, \
      \"Grant\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Grantee\":{\"shape\":\"Grantee\"}, \
          \"Permission\":{ \
            \"shape\":\"Permission\", \
            \"documentation\":\"Specifies the permission given to the grantee.\" \
          } \
        } \
      }, \
      \"GrantFullControl\":{\"type\":\"string\"}, \
      \"GrantRead\":{\"type\":\"string\"}, \
      \"GrantReadACP\":{\"type\":\"string\"}, \
      \"GrantWrite\":{\"type\":\"string\"}, \
      \"GrantWriteACP\":{\"type\":\"string\"}, \
      \"Grantee\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Type\"], \
        \"members\":{ \
          \"DisplayName\":{ \
            \"shape\":\"DisplayName\", \
            \"documentation\":\"Screen name of the grantee.\" \
          }, \
          \"EmailAddress\":{ \
            \"shape\":\"EmailAddress\", \
            \"documentation\":\"Email address of the grantee.\" \
          }, \
          \"ID\":{ \
            \"shape\":\"ID\", \
            \"documentation\":\"The canonical user ID of the grantee.\" \
          }, \
          \"Type\":{ \
            \"shape\":\"Type\", \
            \"documentation\":\"Type of grantee\" \
          }, \
          \"URI\":{ \
            \"shape\":\"URI\", \
            \"documentation\":\"URI of the grantee group.\" \
          } \
        }, \
        \"xmlNamespace\":{ \
          \"prefix\":\"xsi\", \
          \"uri\":\"http://www.w3.org/2001/XMLSchema-instance\" \
        } \
      }, \
      \"Grants\":{ \
        \"type\":\"list\", \
        \"member\":{ \
          \"shape\":\"Grant\", \
          \"locationName\":\"Grant\" \
        } \
      }, \
      \"HeadBucketRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          } \
        } \
      }, \
      \"HeadObjectOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"DeleteMarker\":{ \
            \"shape\":\"DeleteMarker\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-delete-marker\", \
            \"documentation\":\"Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.\" \
          }, \
          \"AcceptRanges\":{ \
            \"shape\":\"AcceptRanges\", \
            \"location\":\"header\", \
            \"locationName\":\"accept-ranges\" \
          }, \
          \"Expiration\":{ \
            \"shape\":\"Expiration\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-expiration\", \
            \"documentation\":\"If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.\" \
          }, \
          \"Restore\":{ \
            \"shape\":\"Restore\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-restore\", \
            \"documentation\":\"Provides information about object restoration operation and expiration time of the restored object copy.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"location\":\"header\", \
            \"locationName\":\"Last-Modified\", \
            \"documentation\":\"Last modified date of the object\" \
          }, \
          \"ContentLength\":{ \
            \"shape\":\"ContentLength\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Length\", \
            \"documentation\":\"Size of the body in bytes.\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"location\":\"header\", \
            \"locationName\":\"ETag\", \
            \"documentation\":\"An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL\" \
          }, \
          \"MissingMeta\":{ \
            \"shape\":\"MissingMeta\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-missing-meta\", \
            \"documentation\":\"This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-version-id\", \
            \"documentation\":\"Version of the object.\" \
          }, \
          \"CacheControl\":{ \
            \"shape\":\"CacheControl\", \
            \"location\":\"header\", \
            \"locationName\":\"Cache-Control\", \
            \"documentation\":\"Specifies caching behavior along the request/reply chain.\" \
          }, \
          \"ContentDisposition\":{ \
            \"shape\":\"ContentDisposition\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Disposition\", \
            \"documentation\":\"Specifies presentational information for the object.\" \
          }, \
          \"ContentEncoding\":{ \
            \"shape\":\"ContentEncoding\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Encoding\", \
            \"documentation\":\"Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.\" \
          }, \
          \"ContentLanguage\":{ \
            \"shape\":\"ContentLanguage\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Language\", \
            \"documentation\":\"The language the content is in.\" \
          }, \
          \"ContentType\":{ \
            \"shape\":\"ContentType\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Type\", \
            \"documentation\":\"A standard MIME type describing the format of the object data.\" \
          }, \
          \"Expires\":{ \
            \"shape\":\"Expires\", \
            \"location\":\"header\", \
            \"locationName\":\"Expires\", \
            \"documentation\":\"The date and time at which the object is no longer cacheable.\" \
          }, \
          \"WebsiteRedirectLocation\":{ \
            \"shape\":\"WebsiteRedirectLocation\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-website-redirect-location\", \
            \"documentation\":\"If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"Metadata\":{ \
            \"shape\":\"Metadata\", \
            \"location\":\"headers\", \
            \"documentation\":\"A map of metadata to store with the object in S3.\", \
            \"locationName\":\"x-amz-meta-\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        } \
      }, \
      \"HeadObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"IfMatch\":{ \
            \"shape\":\"IfMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Match\", \
            \"documentation\":\"Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).\" \
          }, \
          \"IfModifiedSince\":{ \
            \"shape\":\"IfModifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Modified-Since\", \
            \"documentation\":\"Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).\" \
          }, \
          \"IfNoneMatch\":{ \
            \"shape\":\"IfNoneMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"If-None-Match\", \
            \"documentation\":\"Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).\" \
          }, \
          \"IfUnmodifiedSince\":{ \
            \"shape\":\"IfUnmodifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"If-Unmodified-Since\", \
            \"documentation\":\"Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"Range\":{ \
            \"shape\":\"Range\", \
            \"location\":\"header\", \
            \"locationName\":\"Range\", \
            \"documentation\":\"Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"versionId\", \
            \"documentation\":\"VersionId used to reference a specific version of the object.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          } \
        } \
      }, \
      \"HostName\":{\"type\":\"string\"}, \
      \"HttpErrorCodeReturnedEquals\":{\"type\":\"string\"}, \
      \"HttpRedirectCode\":{\"type\":\"string\"}, \
      \"ID\":{\"type\":\"string\"}, \
      \"IfMatch\":{\"type\":\"string\"}, \
      \"IfModifiedSince\":{\"type\":\"timestamp\"}, \
      \"IfNoneMatch\":{\"type\":\"string\"}, \
      \"IfUnmodifiedSince\":{\"type\":\"timestamp\"}, \
      \"IndexDocument\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Suffix\"], \
        \"members\":{ \
          \"Suffix\":{ \
            \"shape\":\"Suffix\", \
            \"documentation\":\"A suffix that is appended to a request that is for a directory on the website endpoint (e.g. if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character.\" \
          } \
        } \
      }, \
      \"Initiated\":{\"type\":\"timestamp\"}, \
      \"Initiator\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ID\":{ \
            \"shape\":\"ID\", \
            \"documentation\":\"If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.\" \
          }, \
          \"DisplayName\":{ \
            \"shape\":\"DisplayName\", \
            \"documentation\":\"Name of the Principal.\" \
          } \
        } \
      }, \
      \"IsLatest\":{\"type\":\"boolean\"}, \
      \"IsTruncated\":{\"type\":\"boolean\"}, \
      \"KeyMarker\":{\"type\":\"string\"}, \
      \"KeyPrefixEquals\":{\"type\":\"string\"}, \
      \"LastModified\":{\"type\":\"timestamp\"}, \
      \"LifecycleConfiguration\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Rules\"], \
        \"members\":{ \
          \"Rules\":{ \
            \"shape\":\"Rules\", \
            \"locationName\":\"Rule\" \
          } \
        } \
      }, \
      \"LifecycleExpiration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Date\":{ \
            \"shape\":\"Date\", \
            \"documentation\":\"Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.\" \
          }, \
          \"Days\":{ \
            \"shape\":\"Days\", \
            \"documentation\":\"Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.\" \
          } \
        } \
      }, \
      \"ListBucketsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Buckets\":{\"shape\":\"Buckets\"}, \
          \"Owner\":{\"shape\":\"Owner\"} \
        } \
      }, \
      \"ListMultipartUploadsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"documentation\":\"Name of the bucket to which the multipart upload was initiated.\" \
          }, \
          \"KeyMarker\":{ \
            \"shape\":\"KeyMarker\", \
            \"documentation\":\"The key at or after which the listing began.\" \
          }, \
          \"UploadIdMarker\":{ \
            \"shape\":\"UploadIdMarker\", \
            \"documentation\":\"Upload ID after which listing began.\" \
          }, \
          \"NextKeyMarker\":{ \
            \"shape\":\"NextKeyMarker\", \
            \"documentation\":\"When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.\" \
          }, \
          \"Prefix\":{ \
            \"shape\":\"Prefix\", \
            \"documentation\":\"When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.\" \
          }, \
          \"Delimiter\":{\"shape\":\"Delimiter\"}, \
          \"NextUploadIdMarker\":{ \
            \"shape\":\"NextUploadIdMarker\", \
            \"documentation\":\"When a list is truncated, this element specifies the value that should be used for the upload-id-marker request parameter in a subsequent request.\" \
          }, \
          \"MaxUploads\":{ \
            \"shape\":\"MaxUploads\", \
            \"documentation\":\"Maximum number of multipart uploads that could have been included in the response.\" \
          }, \
          \"IsTruncated\":{ \
            \"shape\":\"IsTruncated\", \
            \"documentation\":\"Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.\" \
          }, \
          \"Uploads\":{ \
            \"shape\":\"MultipartUploadList\", \
            \"locationName\":\"Upload\" \
          }, \
          \"CommonPrefixes\":{\"shape\":\"CommonPrefixList\"}, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"documentation\":\"Encoding type used by Amazon S3 to encode object keys in the response.\" \
          } \
        } \
      }, \
      \"ListMultipartUploadsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Delimiter\":{ \
            \"shape\":\"Delimiter\", \
            \"location\":\"querystring\", \
            \"locationName\":\"delimiter\", \
            \"documentation\":\"Character you use to group keys.\" \
          }, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"location\":\"querystring\", \
            \"locationName\":\"encoding-type\" \
          }, \
          \"KeyMarker\":{ \
            \"shape\":\"KeyMarker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"key-marker\", \
            \"documentation\":\"Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.\" \
          }, \
          \"MaxUploads\":{ \
            \"shape\":\"MaxUploads\", \
            \"location\":\"querystring\", \
            \"locationName\":\"max-uploads\", \
            \"documentation\":\"Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.\" \
          }, \
          \"Prefix\":{ \
            \"shape\":\"Prefix\", \
            \"location\":\"querystring\", \
            \"locationName\":\"prefix\", \
            \"documentation\":\"Lists in-progress uploads only for those keys that begin with the specified prefix.\" \
          }, \
          \"UploadIdMarker\":{ \
            \"shape\":\"UploadIdMarker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"upload-id-marker\", \
            \"documentation\":\"Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored.\" \
          } \
        } \
      }, \
      \"ListObjectVersionsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"IsTruncated\":{ \
            \"shape\":\"IsTruncated\", \
            \"documentation\":\"A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.\" \
          }, \
          \"KeyMarker\":{ \
            \"shape\":\"KeyMarker\", \
            \"documentation\":\"Marks the last Key returned in a truncated response.\" \
          }, \
          \"VersionIdMarker\":{\"shape\":\"VersionIdMarker\"}, \
          \"NextKeyMarker\":{ \
            \"shape\":\"NextKeyMarker\", \
            \"documentation\":\"Use this value for the key marker request parameter in a subsequent request.\" \
          }, \
          \"NextVersionIdMarker\":{ \
            \"shape\":\"NextVersionIdMarker\", \
            \"documentation\":\"Use this value for the next version id marker parameter in a subsequent request.\" \
          }, \
          \"Versions\":{ \
            \"shape\":\"ObjectVersionList\", \
            \"locationName\":\"Version\" \
          }, \
          \"DeleteMarkers\":{ \
            \"shape\":\"DeleteMarkers\", \
            \"locationName\":\"DeleteMarker\" \
          }, \
          \"Name\":{\"shape\":\"BucketName\"}, \
          \"Prefix\":{\"shape\":\"Prefix\"}, \
          \"Delimiter\":{\"shape\":\"Delimiter\"}, \
          \"MaxKeys\":{\"shape\":\"MaxKeys\"}, \
          \"CommonPrefixes\":{\"shape\":\"CommonPrefixList\"}, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"documentation\":\"Encoding type used by Amazon S3 to encode object keys in the response.\" \
          } \
        } \
      }, \
      \"ListObjectVersionsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Delimiter\":{ \
            \"shape\":\"Delimiter\", \
            \"location\":\"querystring\", \
            \"locationName\":\"delimiter\", \
            \"documentation\":\"A delimiter is a character you use to group keys.\" \
          }, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"location\":\"querystring\", \
            \"locationName\":\"encoding-type\" \
          }, \
          \"KeyMarker\":{ \
            \"shape\":\"KeyMarker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"key-marker\", \
            \"documentation\":\"Specifies the key to start with when listing objects in a bucket.\" \
          }, \
          \"MaxKeys\":{ \
            \"shape\":\"MaxKeys\", \
            \"location\":\"querystring\", \
            \"locationName\":\"max-keys\", \
            \"documentation\":\"Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.\" \
          }, \
          \"Prefix\":{ \
            \"shape\":\"Prefix\", \
            \"location\":\"querystring\", \
            \"locationName\":\"prefix\", \
            \"documentation\":\"Limits the response to keys that begin with the specified prefix.\" \
          }, \
          \"VersionIdMarker\":{ \
            \"shape\":\"VersionIdMarker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"version-id-marker\", \
            \"documentation\":\"Specifies the object version you want to start listing from.\" \
          } \
        } \
      }, \
      \"ListObjectsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"IsTruncated\":{ \
            \"shape\":\"IsTruncated\", \
            \"documentation\":\"A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.\" \
          }, \
          \"Marker\":{\"shape\":\"Marker\"}, \
          \"NextMarker\":{ \
            \"shape\":\"NextMarker\", \
            \"documentation\":\"When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.\" \
          }, \
          \"Contents\":{\"shape\":\"ObjectList\"}, \
          \"Name\":{\"shape\":\"BucketName\"}, \
          \"Prefix\":{\"shape\":\"Prefix\"}, \
          \"Delimiter\":{\"shape\":\"Delimiter\"}, \
          \"MaxKeys\":{\"shape\":\"MaxKeys\"}, \
          \"CommonPrefixes\":{\"shape\":\"CommonPrefixList\"}, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"documentation\":\"Encoding type used by Amazon S3 to encode object keys in the response.\" \
          } \
        } \
      }, \
      \"ListObjectsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Delimiter\":{ \
            \"shape\":\"Delimiter\", \
            \"location\":\"querystring\", \
            \"locationName\":\"delimiter\", \
            \"documentation\":\"A delimiter is a character you use to group keys.\" \
          }, \
          \"EncodingType\":{ \
            \"shape\":\"EncodingType\", \
            \"location\":\"querystring\", \
            \"locationName\":\"encoding-type\" \
          }, \
          \"Marker\":{ \
            \"shape\":\"Marker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"marker\", \
            \"documentation\":\"Specifies the key to start with when listing objects in a bucket.\" \
          }, \
          \"MaxKeys\":{ \
            \"shape\":\"MaxKeys\", \
            \"location\":\"querystring\", \
            \"locationName\":\"max-keys\", \
            \"documentation\":\"Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.\" \
          }, \
          \"Prefix\":{ \
            \"shape\":\"Prefix\", \
            \"location\":\"querystring\", \
            \"locationName\":\"prefix\", \
            \"documentation\":\"Limits the response to keys that begin with the specified prefix.\" \
          } \
        } \
      }, \
      \"ListPartsOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"documentation\":\"Name of the bucket to which the multipart upload was initiated.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"Object key for which the multipart upload was initiated.\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"documentation\":\"Upload ID identifying the multipart upload whose parts are being listed.\" \
          }, \
          \"PartNumberMarker\":{ \
            \"shape\":\"PartNumberMarker\", \
            \"documentation\":\"Part number after which listing begins.\" \
          }, \
          \"NextPartNumberMarker\":{ \
            \"shape\":\"NextPartNumberMarker\", \
            \"documentation\":\"When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.\" \
          }, \
          \"MaxParts\":{ \
            \"shape\":\"MaxParts\", \
            \"documentation\":\"Maximum number of parts that were allowed in the response.\" \
          }, \
          \"IsTruncated\":{ \
            \"shape\":\"IsTruncated\", \
            \"documentation\":\"Indicates whether the returned list of parts is truncated.\" \
          }, \
          \"Parts\":{ \
            \"shape\":\"Parts\", \
            \"locationName\":\"Part\" \
          }, \
          \"Initiator\":{ \
            \"shape\":\"Initiator\", \
            \"documentation\":\"Identifies who initiated the multipart upload.\" \
          }, \
          \"Owner\":{\"shape\":\"Owner\"}, \
          \"StorageClass\":{ \
            \"shape\":\"StorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          } \
        } \
      }, \
      \"ListPartsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\", \
          \"UploadId\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"MaxParts\":{ \
            \"shape\":\"MaxParts\", \
            \"location\":\"querystring\", \
            \"locationName\":\"max-parts\", \
            \"documentation\":\"Sets the maximum number of parts to return.\" \
          }, \
          \"PartNumberMarker\":{ \
            \"shape\":\"PartNumberMarker\", \
            \"location\":\"querystring\", \
            \"locationName\":\"part-number-marker\", \
            \"documentation\":\"Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"uploadId\", \
            \"documentation\":\"Upload ID identifying the multipart upload whose parts are being listed.\" \
          } \
        } \
      }, \
      \"Location\":{\"type\":\"string\"}, \
      \"LoggingEnabled\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"TargetBucket\":{ \
            \"shape\":\"TargetBucket\", \
            \"documentation\":\"Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case you should choose a different TargetPrefix for each source bucket so that the delivered log files can be distinguished by key.\" \
          }, \
          \"TargetGrants\":{\"shape\":\"TargetGrants\"}, \
          \"TargetPrefix\":{ \
            \"shape\":\"TargetPrefix\", \
            \"documentation\":\"This element lets you specify a prefix for the keys that the log files will be stored under.\" \
          } \
        } \
      }, \
      \"MFA\":{\"type\":\"string\"}, \
      \"MFADelete\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"Enabled\", \
          \"Disabled\" \
        ] \
      }, \
      \"MFADeleteStatus\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"Enabled\", \
          \"Disabled\" \
        ] \
      }, \
      \"Marker\":{\"type\":\"string\"}, \
      \"MaxAgeSeconds\":{\"type\":\"integer\"}, \
      \"MaxKeys\":{\"type\":\"integer\"}, \
      \"MaxParts\":{\"type\":\"integer\"}, \
      \"MaxUploads\":{\"type\":\"integer\"}, \
      \"Message\":{\"type\":\"string\"}, \
      \"Metadata\":{ \
        \"type\":\"map\", \
        \"key\":{\"shape\":\"MetadataKey\"}, \
        \"value\":{\"shape\":\"MetadataValue\"} \
      }, \
      \"MetadataDirective\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"COPY\", \
          \"REPLACE\" \
        ] \
      }, \
      \"MetadataKey\":{\"type\":\"string\"}, \
      \"MetadataValue\":{\"type\":\"string\"}, \
      \"MissingMeta\":{\"type\":\"integer\"}, \
      \"MultipartUpload\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"documentation\":\"Upload ID that identifies the multipart upload.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"Key of the object for which the multipart upload was initiated.\" \
          }, \
          \"Initiated\":{ \
            \"shape\":\"Initiated\", \
            \"documentation\":\"Date and time at which the multipart upload was initiated.\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"StorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          }, \
          \"Owner\":{\"shape\":\"Owner\"}, \
          \"Initiator\":{ \
            \"shape\":\"Initiator\", \
            \"documentation\":\"Identifies who initiated the multipart upload.\" \
          } \
        } \
      }, \
      \"MultipartUploadId\":{\"type\":\"string\"}, \
      \"MultipartUploadList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"MultipartUpload\"}, \
        \"flattened\":true \
      }, \
      \"NextKeyMarker\":{\"type\":\"string\"}, \
      \"NextMarker\":{\"type\":\"string\"}, \
      \"NextPartNumberMarker\":{\"type\":\"integer\"}, \
      \"NextUploadIdMarker\":{\"type\":\"string\"}, \
      \"NextVersionIdMarker\":{\"type\":\"string\"}, \
      \"NoSuchBucket\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"The specified bucket does not exist.\" \
      }, \
      \"NoSuchKey\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"The specified key does not exist.\" \
      }, \
      \"NoSuchUpload\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"The specified multipart upload does not exist.\" \
      }, \
      \"NoncurrentVersionExpiration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"NoncurrentDays\":{ \
            \"shape\":\"Days\", \
            \"documentation\":\"Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\\\"/AmazonS3/latest/dev/s3-access-control.html\\\">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.\" \
          } \
        }, \
        \"documentation\":\"Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.\" \
      }, \
      \"NoncurrentVersionTransition\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"NoncurrentDays\":{ \
            \"shape\":\"Days\", \
            \"documentation\":\"Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href=\\\"/AmazonS3/latest/dev/s3-access-control.html\\\">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"TransitionStorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          } \
        }, \
        \"documentation\":\"Container for the transition rule that describes when noncurrent objects transition to the GLACIER storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the GLACIER storage class at a specific period in the object's lifetime.\" \
      }, \
      \"NotificationConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"TopicConfiguration\":{\"shape\":\"TopicConfiguration\"}, \
          \"QueueConfiguration\":{\"shape\":\"QueueConfiguration\"}, \
          \"CloudFunctionConfiguration\":{\"shape\":\"CloudFunctionConfiguration\"} \
        } \
      }, \
      \"NotificationId\":{\"type\":\"string\"}, \
      \"Object\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Key\":{\"shape\":\"ObjectKey\"}, \
          \"LastModified\":{\"shape\":\"LastModified\"}, \
          \"ETag\":{\"shape\":\"ETag\"}, \
          \"Size\":{\"shape\":\"Size\"}, \
          \"StorageClass\":{ \
            \"shape\":\"ObjectStorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          }, \
          \"Owner\":{\"shape\":\"Owner\"} \
        } \
      }, \
      \"ObjectAlreadyInActiveTierError\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"This operation is not allowed against this storage tier\" \
      }, \
      \"ObjectCannedACL\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"private\", \
          \"public-read\", \
          \"public-read-write\", \
          \"authenticated-read\", \
          \"bucket-owner-read\", \
          \"bucket-owner-full-control\" \
        ] \
      }, \
      \"ObjectIdentifier\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Key\"], \
        \"members\":{ \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"Key name of the object to delete.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"documentation\":\"VersionId for the specific version of the object to delete.\" \
          } \
        } \
      }, \
      \"ObjectIdentifierList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"ObjectIdentifier\"}, \
        \"flattened\":true \
      }, \
      \"ObjectKey\":{\"type\":\"string\"}, \
      \"ObjectList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"Object\"}, \
        \"flattened\":true \
      }, \
      \"ObjectNotInActiveTierError\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
        }, \
        \"exception\":true, \
        \"documentation\":\"The source object of the COPY operation is not in the active tier and is only stored in Amazon Glacier.\" \
      }, \
      \"ObjectStorageClass\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"STANDARD\", \
          \"REDUCED_REDUNDANCY\", \
          \"GLACIER\" \
        ] \
      }, \
      \"ObjectVersion\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ETag\":{\"shape\":\"ETag\"}, \
          \"Size\":{ \
            \"shape\":\"Size\", \
            \"documentation\":\"Size in bytes of the object.\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"ObjectVersionStorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"The object key.\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"documentation\":\"Version ID of an object.\" \
          }, \
          \"IsLatest\":{ \
            \"shape\":\"IsLatest\", \
            \"documentation\":\"Specifies whether the object is (true) or is not (false) the latest version of an object.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"documentation\":\"Date and time the object was last modified.\" \
          }, \
          \"Owner\":{\"shape\":\"Owner\"} \
        } \
      }, \
      \"ObjectVersionId\":{\"type\":\"string\"}, \
      \"ObjectVersionList\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"ObjectVersion\"}, \
        \"flattened\":true \
      }, \
      \"ObjectVersionStorageClass\":{ \
        \"type\":\"string\", \
        \"enum\":[\"STANDARD\"] \
      }, \
      \"Owner\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"DisplayName\":{\"shape\":\"DisplayName\"}, \
          \"ID\":{\"shape\":\"ID\"} \
        } \
      }, \
      \"Part\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"PartNumber\":{ \
            \"shape\":\"PartNumber\", \
            \"documentation\":\"Part number identifying the part.\" \
          }, \
          \"LastModified\":{ \
            \"shape\":\"LastModified\", \
            \"documentation\":\"Date and time at which the part was uploaded.\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"documentation\":\"Entity tag returned when the part was uploaded.\" \
          }, \
          \"Size\":{ \
            \"shape\":\"Size\", \
            \"documentation\":\"Size of the uploaded part data.\" \
          } \
        } \
      }, \
      \"PartNumber\":{\"type\":\"integer\"}, \
      \"PartNumberMarker\":{\"type\":\"integer\"}, \
      \"Parts\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"Part\"}, \
        \"flattened\":true \
      }, \
      \"Payer\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"Requester\", \
          \"BucketOwner\" \
        ] \
      }, \
      \"Permission\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"FULL_CONTROL\", \
          \"WRITE\", \
          \"WRITE_ACP\", \
          \"READ\", \
          \"READ_ACP\" \
        ] \
      }, \
      \"Policy\":{\"type\":\"string\"}, \
      \"Prefix\":{\"type\":\"string\"}, \
      \"Protocol\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"http\", \
          \"https\" \
        ] \
      }, \
      \"PutBucketAclRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"BucketCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the bucket.\" \
          }, \
          \"AccessControlPolicy\":{ \
            \"shape\":\"AccessControlPolicy\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"AccessControlPolicy\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to list the objects in the bucket.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the bucket ACL.\" \
          }, \
          \"GrantWrite\":{ \
            \"shape\":\"GrantWrite\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write\", \
            \"documentation\":\"Allows grantee to create, overwrite, and delete any object in the bucket.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable bucket.\" \
          } \
        }, \
        \"payload\":\"AccessControlPolicy\" \
      }, \
      \"PutBucketCorsRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CORSConfiguration\":{ \
            \"shape\":\"CORSConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"CORSConfiguration\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          } \
        }, \
        \"payload\":\"CORSConfiguration\" \
      }, \
      \"PutBucketLifecycleRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Bucket\"], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"LifecycleConfiguration\":{ \
            \"shape\":\"LifecycleConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"LifecycleConfiguration\" \
          } \
        }, \
        \"payload\":\"LifecycleConfiguration\" \
      }, \
      \"PutBucketLoggingRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"BucketLoggingStatus\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"BucketLoggingStatus\":{ \
            \"shape\":\"BucketLoggingStatus\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"BucketLoggingStatus\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          } \
        }, \
        \"payload\":\"BucketLoggingStatus\" \
      }, \
      \"PutBucketNotificationRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"NotificationConfiguration\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"NotificationConfiguration\":{ \
            \"shape\":\"NotificationConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"NotificationConfiguration\" \
          } \
        }, \
        \"payload\":\"NotificationConfiguration\" \
      }, \
      \"PutBucketPolicyRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Policy\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"Policy\":{ \
            \"shape\":\"Policy\", \
            \"documentation\":\"The bucket policy as a JSON document.\" \
          } \
        }, \
        \"payload\":\"Policy\" \
      }, \
      \"PutBucketRequestPaymentRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"RequestPaymentConfiguration\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"RequestPaymentConfiguration\":{ \
            \"shape\":\"RequestPaymentConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"RequestPaymentConfiguration\" \
          } \
        }, \
        \"payload\":\"RequestPaymentConfiguration\" \
      }, \
      \"PutBucketTaggingRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Tagging\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"Tagging\":{ \
            \"shape\":\"Tagging\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"Tagging\" \
          } \
        }, \
        \"payload\":\"Tagging\" \
      }, \
      \"PutBucketVersioningRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"VersioningConfiguration\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"MFA\":{ \
            \"shape\":\"MFA\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-mfa\", \
            \"documentation\":\"The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.\" \
          }, \
          \"VersioningConfiguration\":{ \
            \"shape\":\"VersioningConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"VersioningConfiguration\" \
          } \
        }, \
        \"payload\":\"VersioningConfiguration\" \
      }, \
      \"PutBucketWebsiteRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"WebsiteConfiguration\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"WebsiteConfiguration\":{ \
            \"shape\":\"WebsiteConfiguration\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"WebsiteConfiguration\" \
          } \
        }, \
        \"payload\":\"WebsiteConfiguration\" \
      }, \
      \"PutObjectAclRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"ObjectCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the object.\" \
          }, \
          \"AccessControlPolicy\":{ \
            \"shape\":\"AccessControlPolicy\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"AccessControlPolicy\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to list the objects in the bucket.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the bucket ACL.\" \
          }, \
          \"GrantWrite\":{ \
            \"shape\":\"GrantWrite\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write\", \
            \"documentation\":\"Allows grantee to create, overwrite, and delete any object in the bucket.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable bucket.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          } \
        }, \
        \"payload\":\"AccessControlPolicy\" \
      }, \
      \"PutObjectOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Expiration\":{ \
            \"shape\":\"Expiration\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-expiration\", \
            \"documentation\":\"If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"location\":\"header\", \
            \"locationName\":\"ETag\", \
            \"documentation\":\"Entity tag for the uploaded object.\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-version-id\", \
            \"documentation\":\"Version of the object.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        } \
      }, \
      \"PutObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"ACL\":{ \
            \"shape\":\"ObjectCannedACL\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-acl\", \
            \"documentation\":\"The canned ACL to apply to the object.\" \
          }, \
          \"Body\":{ \
            \"shape\":\"Body\", \
            \"streaming\":true, \
            \"documentation\":\"Object data.\" \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CacheControl\":{ \
            \"shape\":\"CacheControl\", \
            \"location\":\"header\", \
            \"locationName\":\"Cache-Control\", \
            \"documentation\":\"Specifies caching behavior along the request/reply chain.\" \
          }, \
          \"ContentDisposition\":{ \
            \"shape\":\"ContentDisposition\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Disposition\", \
            \"documentation\":\"Specifies presentational information for the object.\" \
          }, \
          \"ContentEncoding\":{ \
            \"shape\":\"ContentEncoding\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Encoding\", \
            \"documentation\":\"Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.\" \
          }, \
          \"ContentLanguage\":{ \
            \"shape\":\"ContentLanguage\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Language\", \
            \"documentation\":\"The language the content is in.\" \
          }, \
          \"ContentLength\":{ \
            \"shape\":\"ContentLength\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Length\", \
            \"documentation\":\"Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"ContentType\":{ \
            \"shape\":\"ContentType\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Type\", \
            \"documentation\":\"A standard MIME type describing the format of the object data.\" \
          }, \
          \"Expires\":{ \
            \"shape\":\"Expires\", \
            \"location\":\"header\", \
            \"locationName\":\"Expires\", \
            \"documentation\":\"The date and time at which the object is no longer cacheable.\" \
          }, \
          \"GrantFullControl\":{ \
            \"shape\":\"GrantFullControl\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-full-control\", \
            \"documentation\":\"Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.\" \
          }, \
          \"GrantRead\":{ \
            \"shape\":\"GrantRead\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read\", \
            \"documentation\":\"Allows grantee to read the object data and its metadata.\" \
          }, \
          \"GrantReadACP\":{ \
            \"shape\":\"GrantReadACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-read-acp\", \
            \"documentation\":\"Allows grantee to read the object ACL.\" \
          }, \
          \"GrantWriteACP\":{ \
            \"shape\":\"GrantWriteACP\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-grant-write-acp\", \
            \"documentation\":\"Allows grantee to write the ACL for the applicable object.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"Metadata\":{ \
            \"shape\":\"Metadata\", \
            \"location\":\"headers\", \
            \"documentation\":\"A map of metadata to store with the object in S3.\", \
            \"locationName\":\"x-amz-meta-\" \
          }, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"StorageClass\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-storage-class\", \
            \"documentation\":\"The type of storage to use for the object. Defaults to 'STANDARD'.\" \
          }, \
          \"WebsiteRedirectLocation\":{ \
            \"shape\":\"WebsiteRedirectLocation\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-website-redirect-location\", \
            \"documentation\":\"If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version\" \
          } \
        }, \
        \"payload\":\"Body\" \
      }, \
      \"Queue\":{\"type\":\"string\"}, \
      \"QueueConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Id\":{\"shape\":\"NotificationId\"}, \
          \"Event\":{ \
            \"shape\":\"Event\", \
            \"deprecated\":true \
          }, \
          \"Events\":{ \
            \"shape\":\"Events\", \
            \"locationName\":\"Event\" \
          }, \
          \"Queue\":{\"shape\":\"Queue\"} \
        } \
      }, \
      \"Quiet\":{\"type\":\"boolean\"}, \
      \"Range\":{\"type\":\"string\"}, \
      \"Redirect\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"HostName\":{ \
            \"shape\":\"HostName\", \
            \"documentation\":\"The host name to use in the redirect request.\" \
          }, \
          \"HttpRedirectCode\":{ \
            \"shape\":\"HttpRedirectCode\", \
            \"documentation\":\"The HTTP redirect code to use on the response. Not required if one of the siblings is present.\" \
          }, \
          \"Protocol\":{ \
            \"shape\":\"Protocol\", \
            \"documentation\":\"Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.\" \
          }, \
          \"ReplaceKeyPrefixWith\":{ \
            \"shape\":\"ReplaceKeyPrefixWith\", \
            \"documentation\":\"The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided.\" \
          }, \
          \"ReplaceKeyWith\":{ \
            \"shape\":\"ReplaceKeyWith\", \
            \"documentation\":\"The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the sibling is present. Can be present only if ReplaceKeyPrefixWith is not provided.\" \
          } \
        } \
      }, \
      \"RedirectAllRequestsTo\":{ \
        \"type\":\"structure\", \
        \"required\":[\"HostName\"], \
        \"members\":{ \
          \"HostName\":{ \
            \"shape\":\"HostName\", \
            \"documentation\":\"Name of the host where requests will be redirected.\" \
          }, \
          \"Protocol\":{ \
            \"shape\":\"Protocol\", \
            \"documentation\":\"Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.\" \
          } \
        } \
      }, \
      \"ReplaceKeyPrefixWith\":{\"type\":\"string\"}, \
      \"ReplaceKeyWith\":{\"type\":\"string\"}, \
      \"RequestPaymentConfiguration\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Payer\"], \
        \"members\":{ \
          \"Payer\":{ \
            \"shape\":\"Payer\", \
            \"documentation\":\"Specifies who pays for the download and request fees.\" \
          } \
        } \
      }, \
      \"ResponseCacheControl\":{\"type\":\"string\"}, \
      \"ResponseContentDisposition\":{\"type\":\"string\"}, \
      \"ResponseContentEncoding\":{\"type\":\"string\"}, \
      \"ResponseContentLanguage\":{\"type\":\"string\"}, \
      \"ResponseContentType\":{\"type\":\"string\"}, \
      \"ResponseExpires\":{\"type\":\"timestamp\"}, \
      \"Restore\":{\"type\":\"string\"}, \
      \"RestoreObjectRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"VersionId\":{ \
            \"shape\":\"ObjectVersionId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"versionId\" \
          }, \
          \"RestoreRequest\":{ \
            \"shape\":\"RestoreRequest\", \
            \"xmlNamespace\":{\"uri\":\"http://s3.amazonaws.com/doc/2006-03-01/\"}, \
            \"locationName\":\"RestoreRequest\" \
          } \
        }, \
        \"payload\":\"RestoreRequest\" \
      }, \
      \"RestoreRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Days\"], \
        \"members\":{ \
          \"Days\":{ \
            \"shape\":\"Days\", \
            \"documentation\":\"Lifetime of the active copy in days\" \
          } \
        } \
      }, \
      \"RoutingRule\":{ \
        \"type\":\"structure\", \
        \"required\":[\"Redirect\"], \
        \"members\":{ \
          \"Condition\":{ \
            \"shape\":\"Condition\", \
            \"documentation\":\"A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.\" \
          }, \
          \"Redirect\":{ \
            \"shape\":\"Redirect\", \
            \"documentation\":\"Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can can specify a different error code to return.\" \
          } \
        } \
      }, \
      \"RoutingRules\":{ \
        \"type\":\"list\", \
        \"member\":{ \
          \"shape\":\"RoutingRule\", \
          \"locationName\":\"RoutingRule\" \
        } \
      }, \
      \"Rule\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Prefix\", \
          \"Status\" \
        ], \
        \"members\":{ \
          \"Expiration\":{\"shape\":\"LifecycleExpiration\"}, \
          \"ID\":{ \
            \"shape\":\"ID\", \
            \"documentation\":\"Unique identifier for the rule. The value cannot be longer than 255 characters.\" \
          }, \
          \"Prefix\":{ \
            \"shape\":\"Prefix\", \
            \"documentation\":\"Prefix identifying one or more objects to which the rule applies.\" \
          }, \
          \"Status\":{ \
            \"shape\":\"ExpirationStatus\", \
            \"documentation\":\"If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.\" \
          }, \
          \"Transition\":{\"shape\":\"Transition\"}, \
          \"NoncurrentVersionTransition\":{\"shape\":\"NoncurrentVersionTransition\"}, \
          \"NoncurrentVersionExpiration\":{\"shape\":\"NoncurrentVersionExpiration\"} \
        } \
      }, \
      \"Rules\":{ \
        \"type\":\"list\", \
        \"member\":{\"shape\":\"Rule\"}, \
        \"flattened\":true \
      }, \
      \"SSECustomerAlgorithm\":{\"type\":\"string\"}, \
      \"SSECustomerKey\":{ \
        \"type\":\"string\", \
        \"sensitive\":true \
      }, \
      \"SSECustomerKeyMD5\":{\"type\":\"string\"}, \
      \"SSEKMSKeyId\":{ \
        \"type\":\"string\", \
        \"sensitive\":true \
      }, \
      \"ServerSideEncryption\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"AES256\", \
          \"aws:kms\" \
        ] \
      }, \
      \"Size\":{\"type\":\"integer\"}, \
      \"StorageClass\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"STANDARD\", \
          \"REDUCED_REDUNDANCY\" \
        ] \
      }, \
      \"Suffix\":{\"type\":\"string\"}, \
      \"Tag\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Key\", \
          \"Value\" \
        ], \
        \"members\":{ \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"documentation\":\"Name of the tag.\" \
          }, \
          \"Value\":{ \
            \"shape\":\"Value\", \
            \"documentation\":\"Value of the tag.\" \
          } \
        } \
      }, \
      \"TagSet\":{ \
        \"type\":\"list\", \
        \"member\":{ \
          \"shape\":\"Tag\", \
          \"locationName\":\"Tag\" \
        } \
      }, \
      \"Tagging\":{ \
        \"type\":\"structure\", \
        \"required\":[\"TagSet\"], \
        \"members\":{ \
          \"TagSet\":{\"shape\":\"TagSet\"} \
        } \
      }, \
      \"TargetBucket\":{\"type\":\"string\"}, \
      \"TargetGrant\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Grantee\":{\"shape\":\"Grantee\"}, \
          \"Permission\":{ \
            \"shape\":\"BucketLogsPermission\", \
            \"documentation\":\"Logging permissions assigned to the Grantee for the bucket.\" \
          } \
        } \
      }, \
      \"TargetGrants\":{ \
        \"type\":\"list\", \
        \"member\":{ \
          \"shape\":\"TargetGrant\", \
          \"locationName\":\"Grant\" \
        } \
      }, \
      \"TargetPrefix\":{\"type\":\"string\"}, \
      \"Topic\":{\"type\":\"string\"}, \
      \"TopicConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Id\":{\"shape\":\"NotificationId\"}, \
          \"Events\":{ \
            \"shape\":\"Events\", \
            \"locationName\":\"Event\" \
          }, \
          \"Event\":{ \
            \"shape\":\"Event\", \
            \"deprecated\":true, \
            \"documentation\":\"Bucket event for which to send notifications.\" \
          }, \
          \"Topic\":{ \
            \"shape\":\"Topic\", \
            \"documentation\":\"Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.\" \
          } \
        } \
      }, \
      \"Transition\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"Date\":{ \
            \"shape\":\"Date\", \
            \"documentation\":\"Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.\" \
          }, \
          \"Days\":{ \
            \"shape\":\"Days\", \
            \"documentation\":\"Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.\" \
          }, \
          \"StorageClass\":{ \
            \"shape\":\"TransitionStorageClass\", \
            \"documentation\":\"The class of storage used to store the object.\" \
          } \
        } \
      }, \
      \"TransitionStorageClass\":{ \
        \"type\":\"string\", \
        \"enum\":[\"GLACIER\"] \
      }, \
      \"Type\":{ \
        \"type\":\"string\", \
        \"enum\":[ \
          \"CanonicalUser\", \
          \"AmazonCustomerByEmail\", \
          \"Group\" \
        ], \
        \"xmlAttribute\":true, \
        \"locationName\":\"xsi:type\" \
      }, \
      \"URI\":{\"type\":\"string\"}, \
      \"UploadIdMarker\":{\"type\":\"string\"}, \
      \"UploadPartCopyOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"CopySourceVersionId\":{ \
            \"shape\":\"CopySourceVersionId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-version-id\", \
            \"documentation\":\"The version of the source object that was copied, if you have enabled versioning on the source bucket.\" \
          }, \
          \"CopyPartResult\":{\"shape\":\"CopyPartResult\"}, \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        }, \
        \"payload\":\"CopyPartResult\" \
      }, \
      \"UploadPartCopyRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"CopySource\", \
          \"Key\", \
          \"PartNumber\", \
          \"UploadId\" \
        ], \
        \"members\":{ \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"CopySource\":{ \
            \"shape\":\"CopySource\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source\", \
            \"documentation\":\"The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.\" \
          }, \
          \"CopySourceIfMatch\":{ \
            \"shape\":\"CopySourceIfMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-match\", \
            \"documentation\":\"Copies the object if its entity tag (ETag) matches the specified tag.\" \
          }, \
          \"CopySourceIfModifiedSince\":{ \
            \"shape\":\"CopySourceIfModifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-modified-since\", \
            \"documentation\":\"Copies the object if it has been modified since the specified time.\" \
          }, \
          \"CopySourceIfNoneMatch\":{ \
            \"shape\":\"CopySourceIfNoneMatch\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-none-match\", \
            \"documentation\":\"Copies the object if its entity tag (ETag) is different than the specified ETag.\" \
          }, \
          \"CopySourceIfUnmodifiedSince\":{ \
            \"shape\":\"CopySourceIfUnmodifiedSince\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-if-unmodified-since\", \
            \"documentation\":\"Copies the object if it hasn't been modified since the specified time.\" \
          }, \
          \"CopySourceRange\":{ \
            \"shape\":\"CopySourceRange\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-range\", \
            \"documentation\":\"The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first ten bytes of the source. You can copy a range only if the source object is greater than 5 GB.\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"PartNumber\":{ \
            \"shape\":\"PartNumber\", \
            \"location\":\"querystring\", \
            \"locationName\":\"partNumber\", \
            \"documentation\":\"Part number of part being copied.\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"uploadId\", \
            \"documentation\":\"Upload ID identifying the multipart upload whose part is being copied.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          }, \
          \"CopySourceSSECustomerAlgorithm\":{ \
            \"shape\":\"CopySourceSSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use when decrypting the source object (e.g., AES256).\" \
          }, \
          \"CopySourceSSECustomerKey\":{ \
            \"shape\":\"CopySourceSSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.\" \
          }, \
          \"CopySourceSSECustomerKeyMD5\":{ \
            \"shape\":\"CopySourceSSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-copy-source-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          } \
        } \
      }, \
      \"UploadPartOutput\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ServerSideEncryption\":{ \
            \"shape\":\"ServerSideEncryption\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption\", \
            \"documentation\":\"The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).\" \
          }, \
          \"ETag\":{ \
            \"shape\":\"ETag\", \
            \"location\":\"header\", \
            \"locationName\":\"ETag\", \
            \"documentation\":\"Entity tag for the uploaded object.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.\" \
          }, \
          \"SSEKMSKeyId\":{ \
            \"shape\":\"SSEKMSKeyId\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-aws-kms-key-id\", \
            \"documentation\":\"If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.\" \
          } \
        } \
      }, \
      \"UploadPartRequest\":{ \
        \"type\":\"structure\", \
        \"required\":[ \
          \"Bucket\", \
          \"Key\", \
          \"PartNumber\", \
          \"UploadId\" \
        ], \
        \"members\":{ \
          \"Body\":{ \
            \"shape\":\"Body\", \
            \"streaming\":true \
          }, \
          \"Bucket\":{ \
            \"shape\":\"BucketName\", \
            \"location\":\"uri\", \
            \"locationName\":\"Bucket\" \
          }, \
          \"ContentLength\":{ \
            \"shape\":\"ContentLength\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-Length\", \
            \"documentation\":\"Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.\" \
          }, \
          \"ContentMD5\":{ \
            \"shape\":\"ContentMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"Content-MD5\" \
          }, \
          \"Key\":{ \
            \"shape\":\"ObjectKey\", \
            \"location\":\"uri\", \
            \"locationName\":\"Key\" \
          }, \
          \"PartNumber\":{ \
            \"shape\":\"PartNumber\", \
            \"location\":\"querystring\", \
            \"locationName\":\"partNumber\", \
            \"documentation\":\"Part number of part being uploaded.\" \
          }, \
          \"UploadId\":{ \
            \"shape\":\"MultipartUploadId\", \
            \"location\":\"querystring\", \
            \"locationName\":\"uploadId\", \
            \"documentation\":\"Upload ID identifying the multipart upload whose part is being uploaded.\" \
          }, \
          \"SSECustomerAlgorithm\":{ \
            \"shape\":\"SSECustomerAlgorithm\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-algorithm\", \
            \"documentation\":\"Specifies the algorithm to use to when encrypting the object (e.g., AES256, aws:kms).\" \
          }, \
          \"SSECustomerKey\":{ \
            \"shape\":\"SSECustomerKey\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key\", \
            \"documentation\":\"Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side&#x200B;-encryption&#x200B;-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.\" \
          }, \
          \"SSECustomerKeyMD5\":{ \
            \"shape\":\"SSECustomerKeyMD5\", \
            \"location\":\"header\", \
            \"locationName\":\"x-amz-server-side-encryption-customer-key-MD5\", \
            \"documentation\":\"Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.\" \
          } \
        }, \
        \"payload\":\"Body\" \
      }, \
      \"Value\":{\"type\":\"string\"}, \
      \"VersionIdMarker\":{\"type\":\"string\"}, \
      \"VersioningConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"MFADelete\":{ \
            \"shape\":\"MFADelete\", \
            \"documentation\":\"Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.\", \
            \"locationName\":\"MfaDelete\" \
          }, \
          \"Status\":{ \
            \"shape\":\"BucketVersioningStatus\", \
            \"documentation\":\"The versioning state of the bucket.\" \
          } \
        } \
      }, \
      \"WebsiteConfiguration\":{ \
        \"type\":\"structure\", \
        \"members\":{ \
          \"ErrorDocument\":{\"shape\":\"ErrorDocument\"}, \
          \"IndexDocument\":{\"shape\":\"IndexDocument\"}, \
          \"RedirectAllRequestsTo\":{\"shape\":\"RedirectAllRequestsTo\"}, \
          \"RoutingRules\":{\"shape\":\"RoutingRules\"} \
        } \
      }, \
      \"WebsiteRedirectLocation\":{\"type\":\"string\"} \
    } \
  } \
   \
  ";
}

@end
