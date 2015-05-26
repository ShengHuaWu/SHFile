# SHFile
The main purpose of this project is to preserve data in the local directory.

However, _SHFile_ is an abstract class, please use its subclass instead.
One subclass _SHTemporaryFile_ is used to store data in the temporary directory,
and the other subclass _SHDocumentsFile_ is used to save data in the documents directory.

## Usage
- The following example is only related to _SHTemporaryFile_ class,
and the usage of _SHDocumentsFile_ is quite similar.

First of all, invoke the set-up method.

    [SHTemporaryFile setUp];

Create a file by a given name and data,
and save the data in the temporary directory.

    NSData *data = ...;
    SHTemporaryFile *file = [SHTemporaryFile fileWithName:@"filename.txt" data:data];
    NSError *error = nil;
    [file saveData:&error];

Retrieve the data from the temporary directory.

    NSData *data = [file retrieveData];
    // ... Do something with the data.

Delete the data in the temporary directory.

    [file deleteData:&error];

Clean up the temporary directory.

    [SHTemporaryFile cleanUp];

It's also possible to save (delete) multiple files at once.

    NSArray *files; // An array contains several SHTemporaryFile instances.
    NSError *error = nil;
    [SHTemporaryFile saveAll:files error:&error];
