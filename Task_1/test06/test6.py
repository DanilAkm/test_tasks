import os
import time 
import stat
import shutil

def filedo():
    SIX_MONTHS = 15780000

    def file_age_in_seconds(pathname):
        return time.time() - os.stat(pathname)[stat.ST_MTIME]

    free = shutil.disk_usage("/")[2]
    filepaths = []
    size = 0
    dir_name = input('provide the dirname: ')
    size_limit = int(input('provide the size limit in Kb: '))


    for path, dirs, files in os.walk(dir_name):
        for f in files:
            fp = os.path.join(path, f)
            filepaths.append(fp)
            try:
                size += os.path.getsize(fp)
            except:
                continue

    print(f"Free: {round(free / (2**30), 2)} GiB")
    print(f'{dir_name} size is {size} bytes')


    for file in filepaths:
        age = file_age_in_seconds(file)
        size = os.stat(file).st_size / 2**10

        if age > SIX_MONTHS and size > size_limit:
            print(f'Deleting {file}...')
            os.remove(file)
        
if __name__ == '__main__':
    filedo()