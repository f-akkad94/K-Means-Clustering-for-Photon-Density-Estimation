plot(a(:,1),a(:,2),'.'); hold on
plot(b(:,1),b(:,2),'r.');
plot(c(:,1),c(:,2),'g.');
plot(d(:,1),d(:,2),'k.');
plot(e(:,1),e(:,2),'c.');

index = kmeans(all_data, 5);
for k = 1:2500
    text(all_data(k,1),all_data(k,2),num2str(index(k))); hold on;
end