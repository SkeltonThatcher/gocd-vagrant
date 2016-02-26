LOG_DIR=/vagrant/log
mkdir -p $LOG_DIR

LOG=$LOG_DIR/log.out

(
    time /vagrant/provision/bootstrap.sh
) 2>&1 | tee $LOG